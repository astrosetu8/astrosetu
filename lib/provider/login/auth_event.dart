part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String phoneNumber;

  LoginEvent({required this.phoneNumber});
}

class OtpVerifyEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;
  final String deviceToken;
  final String deviceId;

  OtpVerifyEvent({
    required this.phoneNumber,
    required this.otp,
    required this.deviceToken,
    required this.deviceId,
  });
}
