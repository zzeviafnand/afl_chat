import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_status.freezed.dart';

part 'user_status.g.dart';

@freezed
class UserStatusModel extends Equatable with _$UserStatusModel {
  const factory UserStatusModel({
    required String uid,
    @Default(0) int milisecondCreatedAt,
    @Default("") String statusText,
    String? statusImageUrl,
  }) = _UserStatusModel;

  factory UserStatusModel.fromJson(Map<String, dynamic> json) =>
      _$UserStatusModelFromJson(json);

  const UserStatusModel._();

  @override
  List<Object?> get props => [uid, statusText, statusImageUrl];
}
