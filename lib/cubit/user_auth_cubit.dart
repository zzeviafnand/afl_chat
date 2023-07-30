import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:project_chat/helper.dart';
import 'package:project_chat/models/user_profile.dart';
import 'package:project_chat/resource/api_repository.dart';


part 'user_auth_state.dart';

part 'user_auth_cubit.freezed.dart';

class UserAuthCubit extends Cubit<UserAuthState> {
  UserAuthCubit() : super(const UserAuthState());
  final ApiRepository apiRepository = ApiRepository();

  Future<void> setFCMToken(token) async {
    try {
      if (state.userProfile != null) {
        await apiRepository.updateUserSCMToken(token, state.userProfile!);
      }
      logger.v("Success Updating User FCM Token");
      logger.v("FCM_TOKEN: $token");
    } catch (e) {
      logger.e("Failed Updating User FCM Token");
    }
  }

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    _validatePhoneNumber(phoneNumber);
    if (state.status.isNumberValid) {
      try {
        emit(state.copyWith(
            status: AuthStatus.loading, phoneNumber: phoneNumber));
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+62 $phoneNumber',
          timeout: const Duration(seconds: 60),
          verificationCompleted: (PhoneAuthCredential credential) {
            emit(state.copyWith(
                phoneNumber: phoneNumber, status: AuthStatus.otpSuccess));
            logger.v(credential);
          },
          verificationFailed: (FirebaseAuthException e) {
            emit(
              state.copyWith(
                  phoneNumber: phoneNumber,
                  status: AuthStatus.failure,
                  message: e.message.toString().split(".").first),
            );
            logger.e(state, [e, e.stackTrace]);
            // logger.e(
            //     "Phone Number Verification Error", [e.message, e.stackTrace]);
          },
          codeSent: (String verificationId, int? resendToken) {
            emit(state.copyWith(
              status: AuthStatus.codeSent,
              verificationId: verificationId,
              resendToken: resendToken,
            ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {},
        );
      } on FirebaseAuthException {
        (e, trace) => emit(
              state.copyWith(
                  phoneNumber: phoneNumber,
                  status: AuthStatus.failure,
                  message: e.message),
            );
        logger.e(state);
      } catch (e, trace) {
        emit(
          state.copyWith(
            phoneNumber: phoneNumber,
            status: AuthStatus.failure,
          ),
        );
        logger.e(state, [e, trace]);
      }
    }
    logger.v(state);
  }

  Future<void> verifyOtp(String otp) async {
    _validateOtp(otp);
    if (state.status.isOtpValid) {
      emit(state.copyWith(status: AuthStatus.loading));
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: state.verificationId!,
        smsCode: otp,
      );

      try {
        var userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);
        if (userCredential.user != null) {
          // final userProfile = UserProfile(
          //   uid: userCredential.user!.uid,
          //   phone: userCredential.user!.phoneNumber!,
          // );
          // await apiRepository.updateUserProfile(userProfile);

          if (FirebaseAuth.instance.currentUser != null) {
            logger.v("OTP Success");
          }
        }
      } catch (e, trace) {
        logger.e("Error OTP Verification", [e, trace]);
      }
    }
    logger.v(state);
  }

  void _validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length >= 6) {
      emit(state.copyWith(
        phoneNumber: phoneNumber,
        status: AuthStatus.numberValid,
      ));
    } else {
      emit(state.copyWith(
          status: AuthStatus.numberInvalid,
          message: "OTP terdiri dari 6 Angka"));
    }
  }

  void _validateOtp(String otp) {
    if (otp.length == 6) {
      emit(state.copyWith(otp: otp, status: AuthStatus.otpValid));
    } else {
      emit(state.copyWith(status: AuthStatus.otpInvalid));
    }
  }

  StreamSubscription? streamListen;

  Future<void> checkUserProfileFromFirebase() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));
      streamListen = FirebaseAuth.instance.authStateChanges().listen(
        (user) async {
          logger.v("Listening Stream from User Profile");
          if (user == null) {
            logger.v('User is currently signed out!');
            emit(const UserAuthState(status: AuthStatus.initial));
          } else {
            logger.v('User is signed in!');
            final userProfile = UserProfile(
              uid: user.uid,
              phone: user.phoneNumber!,
            );
            final userData = await apiRepository.updateUserProfile(userProfile);

            if (userData?.fullName == null) {
              emit(
                state.copyWith(
                    status: AuthStatus.userDataInitializing,
                    userProfile: userData),
              );
            } else {
              emit(
                state.copyWith(
                    status: AuthStatus.userDataLoaded, userProfile: userData),
              );
            }
            logger.v(state);
          }
        },
      );
    } catch (e, trace) {
      logger.e(state, [e, trace]);
    }
  }

  final ImagePicker _picker = ImagePicker();

  Future? uploadProfilePicture() async {
    final result = await _picker.pickImage(source: ImageSource.camera);
    final Reference storageRef =
        FirebaseStorage.instance.ref().child("profilePictures");
    if (result == null) {
      logger.e("No Image Selected");
    } else {
      logger.v("Image Selected");

      File file = File(result.path);
      final TaskSnapshot task =
          await storageRef.child(basename(file.path)).putFile(file);
      final String downloadUrl = await task.ref.getDownloadURL();
      if (state.userProfile != null) {
        updateUserProfile(state.userProfile!.copyWith(photoUrl: downloadUrl));
        logger.v(state.userProfile);
      }
      logger.v("Download URL $downloadUrl");
    }
  }

  String? getUserPicture() {
    return state.userProfile?.photoUrl;
  }

  UserProfile? getUserProfile() {
    return state.userProfile;
  }

  updateUserProfile(UserProfile userProfile) async {
    try {
      final userData =
          await apiRepository.updateUserProfile(userProfile, isEditing: true);
      if (userData?.fullName != null || userData?.fullName != "") {
        emit(
          state.copyWith(
              status: AuthStatus.userDataLoaded, userProfile: userData),
        );
      }
      logger.v(state);
    } catch (e, t) {
      emit(
        state.copyWith(
            status: AuthStatus.userDataChangingError, userProfile: null),
      );
      logger.e("Error Updating User Profile", [e, t]);
    }
  }

  @override
  Future<void> close() {
    streamListen
        ?.cancel()
        .then((value) => logger.v("User Profile Stream Closed"));
    return super.close();
  }

  pop() {
    emit(const UserAuthState());
  }
}
