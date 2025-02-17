import 'package:astrosetu/component/mytext.dart';
import 'package:astrosetu/provider/login/auth_bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../component/myTextForm.dart';
import '../../route/pageroute.dart';
import '../../utils/image.dart';
import '../../utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _phoneController = TextEditingController();
  PhoneNumber number =
      PhoneNumber(isoCode: 'IN'); // Default country is India (IN)

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff26283F),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  showDialog(
                    context: context,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (state is AuthSuccess) {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, RoutePath.otpVerify,
                      arguments: _phoneController.text);
                } else if (state is AuthFailure) {
                  Navigator.pop(context);
                  Utils.snackbarToast(state.error);
                }
              },
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    height: 300.h,
                    child: Stack(
                      alignment: Alignment
                          .center, // Align the stack's children to the center
                      children: [
                        // First Image
                        Positioned(
                          left: 50
                              .w, // You can adjust the left position if needed
                          child: Image.asset(
                            'assets/image/onBoarding3.png', // Add the path to your image
                            width: 100.w, // Scalable width
                            height: 200.h, // Scalable height
                          ),
                        ),
                        // Second Image (Center Image)
                        Positioned(
                          right: 50
                              .w, // Adjust to control overlap with the first image
                          child: Image.asset(
                            'assets/image/onBoarding2.png', // Add the path to your image
                            width: 100.w,
                            height: 200.h,
                          ),
                        ),
                        // Third Image (Last Image)
                        Positioned(
                          left: 100
                              .w, // Adjust to control overlap with the second image
                          child: Image.asset(
                            'assets/image/onBoarding1.png', // Add the path to your image
                            width: 150.w,
                            height: 250.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      MyText(label:  "Login to get started" ,fontSize: 20.sp,fontColor: Colors.white,fontWeight: FontWeight.w600,)
                    ,  // const Text(
                      //  ,
                      //   style: TextStyle(
                      //     fontFamily: "Segoe UI",
                      //     fontSize: 24,
                      //     fontWeight: FontWeight.bold,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 65.h,
                            height: 45.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey), // Grey border
                              borderRadius: BorderRadius.circular(
                                  5), // Optional: Rounded corners
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5), // Padding inside the container
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(ImagePath.flag),
                                SizedBox(width: 1),
                                MyText(label: "+91",fontColor: Colors.white,)
                                // Text(
                                //   , // India country code
                                //   style: TextStyle(
                                //       color: Colors.white), // White text color
                                // ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Expanded(flex: 3,
                              child: _buildPhoneField()),
                        ],
                      ),

                      SizedBox(height: 20.h),
                      SizedBox(
                        height: 45.h,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<AuthBloc>(context).add(
                                  LoginEvent(phoneNumber: _phoneController.text));

                              print('Phone number: ${_phoneController.text}');
                              // You can add the logic for OTP request here.
                            }
                          },
                          child: Text(
                            'GET OTP',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight:
                              FontWeight.bold, // Set the font weight to medium
                              fontSize: 16.0, // Set a reasonable font size
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Colors.white, // Background color of the button
                            padding: EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 30.0), // Padding inside the button
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8.0), // Rounded corners
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      TermsText(),

                      // Text(
                      //   "By signing up, you agree to our Terms of Use and Privacy Policy",
                      //   textAlign: TextAlign.center,
                      //   style: GoogleFonts.poppins(
                      //     color: Colors.white,
                      //     fontWeight:
                      //         FontWeight.w500, // Set the font weight to medium
                      //     fontSize: 14.sp, // Set a reasonable font size
                      //   ),
                      // ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          // Left Divider
                          Expanded(
                            child: Divider(
                              color: Colors.white, // Divider color
                              thickness: 1, // Divider thickness
                            ),
                          ),

                          // Center Text
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: MyText(
                             label : 'or',

                                  fontWeight: FontWeight.w600, fontColor: Colors.white),

                          ),

                          // Right Divider
                          Expanded(
                            child: Divider(
                              color: Colors.white, // Divider color
                              thickness: 1, // Divider thickness
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialButton(ImagePath.google),
                            SizedBox(
                              width: 20.h,
                            ),
                            _buildSocialButton(ImagePath.facebook),
                          ],
                        ),
                      ),
                    ],),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String iconPath) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset(iconPath, height: 30.h),
    );
  }

  Widget _buildPhoneField() {
    return MyTextForm(
      label: "Enter Mobile Number",
      labelColor: Colors.white,
      controller: _phoneController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(
            10), // Limit input to 10 digits for phone number
        FilteringTextInputFormatter.digitsOnly, // Allow only digits
      ],
      keyboardType: TextInputType.phone, // Phone keyboard for easier input
      borderColor: Colors.grey,
      fillColor: Colors.transparent,
      hintColor: Colors.white,
      styleColor: Colors.white,
      validator: true, // Enable validation
      validatorFunc: Utils.phoneValidator(),
      // prefix: SizedBox(
      //   width: 20.w,
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       SizedBox(width: 5.w),
      //       // Text("🇮🇳"), // Flag emoji as country code prefix
      //
      //       Text("+91"), // India country code
      //     ],
      //   ),
      // ),
      onChanged: (String value) {
        // Handle phone number change logic here if needed
      },
    );
  }
}

class TermsText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: "By signing up, you agree to our ",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: "Terms of Use",
                style: GoogleFonts.poppins(
                  color: Colors.blue, // Link color
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline, // Underline the text
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print("Terms of Use Clicked!");
                    // TODO: Navigate to Terms of Use screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen()));
                  },
              ),
              TextSpan(
                text: " and ",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextSpan(
                text: "Privacy Policy",
                style: GoogleFonts.poppins(
                  color: Colors.blue, // Link color
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline, // Underline the text
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print("Privacy Policy Clicked!");
                    // TODO: Navigate to Privacy Policy screen
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()));
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
