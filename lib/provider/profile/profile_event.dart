part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class UpdateProfileEvent extends ProfileEvent {
  //final String filePath;
  final String name;
  final String gender;
  final String dob;

  UpdateProfileEvent({
   // required this.filePath,
    required this.name,
    required this.gender,
    required this.dob,
  });
}
