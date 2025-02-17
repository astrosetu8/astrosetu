import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../config/share_pref.dart';
import 'authrepo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading()); // Emit loading state while fetching the OTP
      try {



        final response = await LoginRepo().getLogin(event.phoneNumber);
        print("response ${response.data}");
        if (response.data['success'] == true) {
          emit(AuthSuccess(data: ">>>>>>>>>>OTP sent successfully",));
        } else {
          emit(AuthFailure(error:"Failed to send OTP. Please try again.",));
        }
      } catch (e) {
        emit(AuthFailure(error: "An error occurred: $e",));
      }
    });
    on<OtpVerifyEvent>(_onOtpVerifyEvent);
  }


  Future<void> _onOtpVerifyEvent(OtpVerifyEvent event, Emitter<AuthState> emit) async {
    try {
      emit(OtpVerifiedLoading());

      var data = json.encode({
        "number": event.phoneNumber,
        "otp": event.otp,
        "deviceToken": event.deviceToken,
        "deviceId": event.deviceId,
      });

      final response = await LoginRepo().getVerifyOtp(data);

      print("object ${response.data}");

      if (response.data['success'] == true) {
        String accessToken = response.data['token']; // Extract the token

        // Save the access token to shared preferences
        await storeAccessToken(accessToken);


        emit(OtpVerifiedSuccess(data: response.data));
      } else {
        emit(OtpVerifiedFailure(error: response.data['message'] ?? 'Unknown error'));
      }
    } catch (e) {

      print("object ${e}");
      emit(OtpVerifiedFailure(error: e.toString()));
    }
  }

}
