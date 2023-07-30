import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:project_chat/helper.dart';
import 'package:project_chat/resource/api_repository.dart';

import '../models/user_status.dart';

part 'users_status_state.dart';

part 'users_status_cubit.freezed.dart';

class UsersStatusCubit extends Cubit<UsersStatusState> {
  UsersStatusCubit() : super(const UsersStatusState.initial());
  final ApiRepository apiRepository = ApiRepository();

  void testNotification() {}

  Future<void> createStatus(UserStatusModel userStatus) async {
    try {
      emit(const UsersStatusState.loading());
      await uploadProfilePicture(userStatus);
      logger.v("Creating Status State", state);
    } catch (e, t) {
      emit(const UsersStatusState.error());
      logger.e("Error Creating Status", e, t);
    }
  }

  Future<void> getAllStatus() async {
    try {
      emit(const UsersStatusState.loading());
      List<UserStatusModel> userStatuses = await apiRepository
          .getAllStatuses()
          .then((value) => value.docs.map((e) => e.data()).toList());
      emit(UsersStatusState.loaded(userStatuses: userStatuses));
      logger.v("Getting Statuses State", state);
    } catch (e, t) {
      emit(const UsersStatusState.error());
      logger.e("Error Get All Statuses", e, t);
    }
  }

  Future? uploadProfilePicture(UserStatusModel userStatus) async {
    final ImagePicker picker = ImagePicker();
    final result = await picker.pickImage(source: ImageSource.gallery);
    final Reference storageRef =
        FirebaseStorage.instance.ref().child("userStatusesImage");
    if (result == null) {
      logger.e("No Image Selected");
    } else {
      logger.v("Image Selected");

      File file = File(result.path);
      final TaskSnapshot task =
          await storageRef.child(basename(file.path)).putFile(file);
      final String downloadUrl = await task.ref.getDownloadURL();
      await apiRepository.createStatus(
        userStatus.copyWith(statusImageUrl: downloadUrl),
      );
      logger.v("Download URL $downloadUrl");
    }
  }
}
