import 'dart:convert';
import 'package:astrosetu/provider/profile/profile_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../config/share_pref.dart';
import '../../modals/astro_profile.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<UpdateProfileEvent>((event, emit) async {

      emit(ProfileLoading());
      try {
        var data = FormData.fromMap({
          // 'files': [
          //   await MultipartFile.fromFile(event.filePath, filename: 'profile_image.jpg')
          // ],
          'name': event.name,
          'gender': event.gender,
          'dob': event.dob
        });
        final response = await ProfileRepo().updateProfile(data);

        print("object${response.data}");

       // final response = await updateProfile(event);
        if (response.statusCode == 200) {

          emit(ProfileLoaded(response.data));
        } else {
          emit(ProfileError('Failed to update profile'));
        }
      } catch (e) {
        emit(ProfileError('An error occurred: $e'));
      }
    });
  }
  //
  // Future<Response> updateProfile(UpdateProfileEvent event) async {
  //   var headers = {
  //     'Authorization': 'Bearer <your_token_here>'  // Replace with your token
  //   };
  //
  //   var data = FormData.fromMap({
  //     'files': [
  //       await MultipartFile.fromFile(event.filePath, filename: 'profile_image.jpg')
  //     ],
  //     'name': event.name,
  //     'gender': event.gender,
  //     'dob': event.dob
  //   });
  //
  //   return await dio.request(
  //     'http://65.1.117.252:5001/api/user/auth/update_profile',
  //     options: Options(
  //       method: 'PUT',
  //       headers: headers,
  //     ),
  //     data: data,
  //   );
  // }
}
