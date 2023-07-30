part of 'user_auth_cubit.dart';

enum AuthStatus {
  initial,
  empty,
  loading,
  numberValid,
  numberInvalid,
  codeSent,
  numberError,
  otpSuccess,
  otpError,
  failure,
  otpValid,
  otpInvalid,
  userDataInitializing,
  userDataLoaded,
  userDataChangingError,
}

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;

  bool get isEmpty => this == AuthStatus.empty;

  bool get isLoading => this == AuthStatus.loading;

  bool get isCodeSent => this == AuthStatus.codeSent;

  bool get isNumberError => this == AuthStatus.numberError;

  bool get isOtpSuccess => this == AuthStatus.otpSuccess;

  bool get isOtpError => this == AuthStatus.otpError;

  bool get isOtpValid => this == AuthStatus.otpValid;

  bool get isOtpInvalid => this == AuthStatus.otpInvalid;

  bool get isFailure => this == AuthStatus.failure;

  bool get isNumberValid => this == AuthStatus.numberValid;

  bool get isNumberInvalid => this == AuthStatus.numberInvalid;

  bool get isUserDataLoaded => this == AuthStatus.userDataLoaded;

  bool get isUserDataInitializing => this == AuthStatus.userDataInitializing;

  bool get isUserDataChangingError => this == AuthStatus.userDataChangingError;
}

@freezed
class UserAuthState with _$UserAuthState {
  const factory UserAuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    UserProfile? userProfile,
    String? phoneNumber,
    String? otp,
    String? message,
    String? verificationId,
    int? resendToken,
    String? detailedMessage,
  }) = _UserAuthState;
}
