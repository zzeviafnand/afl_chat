import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_chat/models/user_profile.dart';
import 'package:project_chat/resource/api_provider.dart';

extension UserProfileApiProvider on ApiProvider {
  Future<UserProfile?> updateUserProfile(UserProfile userProfile,
      {bool? isEditing}) async {
    var userRef = db.collection('users').doc(userProfile.phone).withConverter(
        fromFirestore: (snapshot, options) =>
            UserProfile.fromJson(snapshot.data()!),
        toFirestore: (value, options) => userProfile.toJson());
    var userProfileData = await userRef.get();
    if (isEditing == true) {
      if (userProfile != userProfileData.data()) {
        await userRef.set(
          userProfile,
          SetOptions(merge: true),
        );
        userProfileData = await userRef.get();
        return userProfileData.data();
      }
    }
    if (userProfileData.data() != null) {
      return userProfileData.data()!;
    } else {
      await userRef.set(
        userProfile,
        SetOptions(merge: true),
      );
    }
    return null;
  }

  Future<void> updateUserSCMToken(String token, UserProfile userProfile) async {
    var userRef = db.collection('users').doc(userProfile.phone).withConverter(
          fromFirestore: (snapshot, options) =>
              UserProfile.fromJson(snapshot.data()!),
          toFirestore: (value, options) => userProfile.toJson(),
        );
    await userRef.update({"fcmToken": token});
  }
}
