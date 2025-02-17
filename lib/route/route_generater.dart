
import 'package:astrosetu/route/pageroute.dart';
import 'package:astrosetu/view/navbar/home.dart';

import 'package:flutter/material.dart';

import '../view/auth/login.dart';
import '../view/auth/verify_otp.dart';
import '../view/navbar/bottom_sheat.dart';
import '../view/onboard.dart';
import '../view/profile/create_profile.dart';
import '../view/splash.dart';


class MyRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
    /// Splash Screen
      case RoutePath.splash:
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );

    ///Welcome screen
      case RoutePath.onboard:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());


    ///Login screen
      case RoutePath.login:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );



    /// OTP Verify Screen
      case RoutePath.otpVerify:
        return MaterialPageRoute(
          builder: (context) {
            final phoneNumber = settings.arguments as String; // Get the phone number passed from the previous screen
            return VerifyOtpScreen(phoneno: phoneNumber); // Pass the phone number to VerifyOtpScreen
          },
        );


    /// Home Screen
      case RoutePath.createProfileScreen:
        return MaterialPageRoute(
          builder: (_) => CreateProfileScreen(),
        );


    /// Home Screen
      case RoutePath.bottomNavigation:
        return MaterialPageRoute(
          builder: (_) => BottomNavigation(),
        );


    //   /// QuestionScreen Screen
      // case RoutePath.profileRegister:
      //   return MaterialPageRoute(
      //     builder: (_) => ProfileRegisterScreen(),
      //   );

    // /// Edit ForgotPassword Screen
    //   case RoutePath.forgotPassword:
    //     return MaterialPageRoute(
    //       builder: (_) => ForgotPasswordScreen(),
    //     );
    //
    // // /// Notification Screen
    //   case RoutePath.otpVerify:
    //     return MaterialPageRoute(
    //       builder: (_) => OTPVerificationScreen(),
    //     );
    // /// Notification Screen
    //   case RoutePath.resetPassword:
    //     return MaterialPageRoute(
    //       builder: (_) => ResetPasswordScreen(),
    //     );
    //
    //
    //   case RoutePath.homePage:
    //     return MaterialPageRoute(
    //       builder: (_) => HomeScreen(),
    //     );
    //
    //   case RoutePath.myNavbarScreen:
    //     return MaterialPageRoute(
    //       builder: (_) => MyNavbarScreen(),
    //     );


    // /// AboutUs Screen
    //   case RoutePath.aboutUs:
    //     return MaterialPageRoute(
    //       builder: (_) => AboutUsScreen(),
    //     );
    //
    // /// Terms Screen
    //   case RoutePath.termsAndConditions:
    //     return MaterialPageRoute(
    //       builder: (_) => TermsConditionScreen(),
    //     );
    //
    // /// Version Screen
    //   case RoutePath.versionScreen:
    //     return MaterialPageRoute(
    //       builder: (_) => VersionScreen(),
    //     );
    //
    // /// Legal Screen
    //   case RoutePath.legalScreen:
    //     return MaterialPageRoute(
    //       builder: (_) => LegalScreen(),
    //     );
    //
    // /// PrivacyPolicy Screen
    //
    //   case RoutePath.privacyPolicyScreen:
    //     return MaterialPageRoute(
    //       builder: (_) => PrivacyPolicy(),
    //     );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }

//   static void navigateToHome(BuildContext context) {
//     Navigator.pushAndRemoveUntil(
//         context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
//   }
//
//   static void navigateToSettingsScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.settingScreen);
//   }
//
//   static void navigateToNotificationScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.notification);
//   }
//
//   static void navigateToLegalScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.legalScreen);
//   }
//
//   static void navigateToVersionScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.versionScreen);
//   }
//
//   static void navigateToAboutScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.aboutUs);
//   }
//
//   static void navigateToTermsScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.termsAndConditions);
//   }
//
//   static void navigateToPolicyScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.privacyPolicyScreen);
//   }
//
//   static void navigateToProfileScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.profile);
//   }
//
//   static void navigateToProfileEditScreen(BuildContext context) {
//     Navigator.pushNamed(context, RoutePath.editProfile);
//   }
// //
// // static void navigateToOtpScreen(BuildContext context, String mobileNumber) {
// //   Navigator.pushNamed(context, '/otp_screen', arguments: mobileNumber);
// // }
// //
// // static void navigateToProfile({required BuildContext context, String? argument1, int? argument2, bool? argument3}) {
// //   Navigator.pushNamed(context, '/profile', arguments: {
// //     'argument1': argument1,
// //     'argument2': argument2,
// //     'argument3': argument3,
// //   });
// // }
// }
}