import 'package:astrosetu/route/pageroute.dart';
import 'package:astrosetu/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../config/share_pref.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Welcome",
      "description":
          "Get ready to explore your horoscope \nand learn more about yourself",
      "image": ImagePath.onboard1
    },
    {
      "title": "Personalized \nAstrology Insights",
      "description": "Uncover your unique cosmic blueprint with tailored horoscopes, natal charts, and daily predictions.",
      "image": ImagePath.onboard2
    },
    {
      "title": "Astrology at Your Fingertips",
      "description": "Chat with professional astrologers and gain clarity on your life's journey.",
      "image": ImagePath.onboard3
    },
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff26283F),
      body: Stack(
        children: [
       _currentPage == 1
         ? Positioned(

              top: 40.h,
              //right: 20.w,
              child: Image.asset(ImagePath.rectangle1)
          )
       :SizedBox(),
          _currentPage == 2
         ? Positioned(
              right: 0.h,

              child: Image.asset(ImagePath.rectangle2)
          )
       :SizedBox(),
          // PageView with dynamic content
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image section
                    Container(
                      height: 350.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_onboardingData[index]["image"]!),
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    // Text(
                    //   "Hello, Flutter!",
                    //   style: GoogleFonts.poppins(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w600,
                    //     color: Colors.black,
                    //   ),
                    // ),

                    Text(
                      _onboardingData[index]["title"]!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Description section
                    Text(
                      _onboardingData[index]["description"]!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(

                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),


          Positioned(
            top: 40.h,
            right: 20.w,
            child: TextButton(
              onPressed: NavigatorClass,
              child: Text(
                "Skip",
                style: TextStyle(color: _currentPage == 2 ?Colors.black :Colors.white),
              ),
            ),
          ),

          // // Page indicator dots
          // Positioned(
          //   bottom: 120.h,
          //   left: 0,
          //   right: 0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: List.generate(
          //       _onboardingData.length,
          //           (index) => AnimatedContainer(
          //         duration: const Duration(milliseconds: 300),
          //         margin: const EdgeInsets.symmetric(horizontal: 4),
          //         height: 8.h,
          //         width: _currentPage == index ? 16.w : 8.w,
          //         decoration: BoxDecoration(
          //           color: _currentPage == index ? Colors.blue : Colors.grey,
          //           borderRadius: BorderRadius.circular(4.r),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          // Next/Get Started button
          Positioned(
            bottom: 25.h,
            left: 20.w,
            right: 20.w,
            child: _currentPage == _onboardingData.length - 1
                ? GestureDetector(
                    onTap: ()   {
                      NavigatorClass();

                    },
                    child: Center(
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white),
                        child: Center(
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: _nextPage,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          //borderRadius: BorderRadius.circular(100),
                          color: Colors.white),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
  NavigatorClass () async {
    await storeOnBoard(true);

    Navigator.pushNamed(context, RoutePath.login);
  }
}
