import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:project_chat/helper.dart';
import 'package:project_chat/models/user_profile.dart';
import 'package:project_chat/resource/api_repository.dart';

part 'contact_list_state.dart';

part 'contact_list_cubit.freezed.dart';

class ContactListCubit extends Cubit<ContactListState> {
  ContactListCubit() : super(const ContactListState.initial());
  final ApiRepository apiRepository = ApiRepository();

  Future<void> getAllContacts() async {
    try {
      emit(const ContactListState.loading());
      List<UserProfile> userProfiles = await apiRepository
          .getContacts()
          .then((value) => value.docs.map((e) => e.data()).toList());
      emit(ContactListState.loaded(userProfiles: userProfiles));
      logger.v("Current contact state is Loaded");
    } catch (e, s) {
      emit(ContactListState.error(e: e, s: s));
      logger.e("Error when getting user profiles as contacts", e, s);
    }
  }

  UserProfile? getUserProfileFromPhone(String phoneNumber) {
    return state.whenOrNull(
      loaded: (userProfiles) =>
          userProfiles.firstWhere((element) => element.phone == phoneNumber),
    );
  }

  UserProfile? getUserProfileFromUID(String uid) {
    return state.whenOrNull(
      loaded: (userProfiles) => userProfiles.firstWhere(
        (element) => element.uid == uid,
        orElse: () {
          return UserProfile(
              uid: FirebaseAuth.instance.currentUser!.uid,
              phone: FirebaseAuth.instance.currentUser!.phoneNumber ?? "");
        },
      ),
    );
  }
}
