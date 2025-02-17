part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String,dynamic> data;

  ProfileLoaded(this.data);
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
