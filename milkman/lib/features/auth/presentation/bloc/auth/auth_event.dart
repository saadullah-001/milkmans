part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginEvent extends AuthEvent {
  final String phoneNumber;

  const AuthLoginEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class AuthPhoneCheckEvent extends AuthEvent {
  final String phoneNumber;

  const AuthPhoneCheckEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class AuthLogoutEvent extends AuthEvent {
  const AuthLogoutEvent();
}

class AuthSendOTPEvent extends AuthEvent {
  final String phoneNumber;

  const AuthSendOTPEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class AuthResendOTPEvent extends AuthEvent {
  final String phoneNumber;

  const AuthResendOTPEvent({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class AuthVerifyOTPEvent extends AuthEvent {
  final String otpCode;

  const AuthVerifyOTPEvent({required this.otpCode});

  @override
  List<Object?> get props => [otpCode];
}
