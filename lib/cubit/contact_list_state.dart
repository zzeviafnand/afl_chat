part of 'contact_list_cubit.dart';

@freezed
class ContactListState with _$ContactListState {
  const factory ContactListState.initial() = _Initial;
  const factory ContactListState.loading() = _Loading;
  const factory ContactListState.loaded({required List<UserProfile> userProfiles}) = _Loaded;
  const factory ContactListState.error({required Object e,required  StackTrace s}) = _Error;
}
