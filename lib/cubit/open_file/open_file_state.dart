part of 'open_file_cubit.dart';

@freezed
class OpenFileState with _$OpenFileState {
  const factory OpenFileState.initial() = _Initial;

  const factory OpenFileState.loading({
    String? message,
  }) = _Loading;

  const factory OpenFileState.loaded() = _Loaded;

  const factory OpenFileState.error({required String message}) = _Error;
}
