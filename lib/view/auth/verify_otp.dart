import 'dart:async';
import 'package:flutter/material.dart';
import 'package:astrosetu/component/mytext.dart';
import 'package:astrosetu/view/profile/create_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import '../../provider/login/auth_bloc.dart';
import '../../route/pageroute.dart';
import '../../utils/utils.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneno;
  VerifyOtpScreen({super.key, required this.phoneno});

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  int _secondsRemaining = 60;
  bool _isResendAvailable = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _isResendAvailable = false;
    _secondsRemaining = 30;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isResendAvailable = true;
        });
        _timer?.cancel();
      }
    });
  }

  void _resendOtp() {
    if (_isResendAvailable) {
      _startTimer();
      // Implement OTP resend logic here
    }
  }

  void _verifyOTP() {
    if (_formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(context).add(OtpVerifyEvent(
          phoneNumber: widget.phoneno,
          otp: _otpController.text.toString(),
          deviceToken: "deviceToken",
          deviceId: "deviceId"));
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Astro Setu", style: TextStyle(fontWeight: FontWeight.w700)),
        leadingWidth: 70,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is OtpVerifiedLoading) {
                showDialog(
                  context: context,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (state is OtpVerifiedSuccess) {
                Navigator.pop(context);
                bool profileDetail = state.data["data"]["is_profile_complete"];
                if (!profileDetail) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CreateProfileScreen()));
                } else {
                  Navigator.pushReplacementNamed(context, RoutePath.bottomNavigation);
                }
                Utils.snackbarToast("OTP Verified Successfully!");
              } else if (state is OtpVerifiedFailure) {
                Navigator.pop(context);
                Utils.snackbarToast(state.error);
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text("Verify Your Number", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    children: [
                      TextSpan(text: "Enter 4-digit verification code sent to your phone number +91 ${widget.phoneno} "),
                      WidgetSpan(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context); // Navigate back to login
                          },
                          child: Text("Edit", style: TextStyle(color: Colors.blue, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
//                 MyText( label:
//                   "Enter 4-digit verification code sent to your phone number +91 ${widget.phoneno}  Edit",
// alignment: true,
//               fontSize: 14.sp,
//                 ),
                const SizedBox(height: 30),
                Pinput(
                  length: 4,
                  controller: _otpController,
                  showCursor: true,
                  validator: (value) {
                    if (value == null || value.length < 4) {
                      return "Enter a valid OTP";
                    }
                    return null;
                  },
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _isResendAvailable
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          MyText( label: "Didn’t get OTP?",fontColor: Colors.black,),
                          InkWell(
                              onTap: _resendOtp,
                              child: MyText( label: " Resend OTP",fontColor: Colors.blue.shade800,)),

                      ],
                    )
                    : Align(
                    alignment: Alignment.centerRight,
                    child: Text("Resend OTP in $_secondsRemaining seconds", style: TextStyle(color: Colors.grey))),
                Expanded(child: const SizedBox(height: 20)),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff26283F),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _verifyOTP,
                    child: MyText(label: "Verify", fontWeight: FontWeight.w600, fontSize: 16.sp,fontColor: Colors.white,),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
