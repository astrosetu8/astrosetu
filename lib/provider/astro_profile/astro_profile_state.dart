part of 'astro_profile_bloc.dart';

@immutable
sealed class AstroProfileState {}

final class AstroProfileInitial extends AstroProfileState {}
final class AstrologerByIdLoading extends AstroProfileState {}



/// State when an error occurs while fetching data
final class AstrologerByIdError extends AstroProfileState {
  final String message;

  AstrologerByIdError(this.message);
}

final class AstrologerByIdLoaded extends AstroProfileState {
  final AstroProfileModal astrologersProfile;

  AstrologerByIdLoaded(this.astrologersProfile);
}
