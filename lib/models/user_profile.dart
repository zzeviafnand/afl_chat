import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';

part 'user_profile.g.dart';

@freezed
class UserProfile extends Equatable with _$UserProfile {
  const factory UserProfile({
    @Default("NONEUID") String uid,
    required String phone,
    String? fullName,
    String? bio,
    String? photoUrl,
    String? fcmToken,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  const UserProfile._();

  @override
  List<Object?> get props => [uid, fullName, bio, photoUrl];
}
