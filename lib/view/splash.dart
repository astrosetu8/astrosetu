import 'dart:async';
import 'package:astrosetu/config/share_pref.dart';
import 'package:astrosetu/route/pageroute.dart';
import 'package:astrosetu/route/route_generater.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'call/call_screen.dart';
import 'chat_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    String? token = await getAccessToken();
    bool? isFirstTime = await getOnBoardStatus();


print("isFirstTime  $isFirstTime");
    // Wait for 3 seconds before navigating
    Timer(Duration(seconds: 3), () {
      if (token != null && token.isNotEmpty) {
        // Navigate to Bottom Navigation Bar if token exists
        Navigator.pushReplacementNamed(context, RoutePath.bottomNavigation);
      } else {
        (!isFirstTime)
       ? Navigator.pushReplacementNamed(context, RoutePath.onboard)
            :
        Navigator.push(context,
          MaterialPageRoute(
            builder: (_) => CallScreen(
              callerName: "sumit",
            ),
          ),
        );
        // Navigator.pushReplacementNamed(context, RoutePath.login);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF9ED), // Splash screen background color
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            "assets/image/splashLogo.png",
            width: 200.h,
          ),
        ),
      ),
      bottomSheet: Container(
        color: Color(0xffFFF9ED),
        padding: const EdgeInsets.all(8.0),
        child: Text(
          'Unlock Your Cosmic Potential: Navigate Life with Astrology',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            // fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
