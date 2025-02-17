part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final dynamic data;

  AuthSuccess({required this.data});
}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required this.error});
}

class OtpVerifiedLoading extends AuthState {}
class OtpVerifiedSuccess extends AuthState {
  final dynamic data;

  OtpVerifiedSuccess({required this.data});
}

class OtpVerifiedFailure extends AuthState {
  final String error;

  OtpVerifiedFailure({required this.error});
}
