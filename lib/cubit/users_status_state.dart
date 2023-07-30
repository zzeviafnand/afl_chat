part of 'users_status_cubit.dart';

@freezed
class UsersStatusState with _$UsersStatusState {
  const factory UsersStatusState.initial() = _Initial;

  const factory UsersStatusState.loading() = _Loading;

  const factory UsersStatusState.error() = _Error;

  const factory UsersStatusState.loaded({
    required List<UserStatusModel> userStatuses,
  }) = _Loaded;

  const factory UsersStatusState.created() = _Created;
}
