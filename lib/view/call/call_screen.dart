import 'package:astrosetu/component/mytext.dart';
import 'package:astrosetu/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CallScreen extends StatelessWidget {
  final String callerName;

  CallScreen({required this.callerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // App Bar with caller's name
      appBar: AppBar(
        title: MyText(label: callerName, fontColor: Colors.white, fontSize: 20.sp),
        backgroundColor: Colors.black54,
      ),

      body: Column(
        children: [
          Expanded(
            flex: 3, // Main content takes most space
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Centers content properly
                children: [
                  // Caller Image from assets
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(ImagePath.facebook),
                  ),
                  SizedBox(height: 20),

                  // Calling status text
                  MyText(
                    label: "Calling...",
                    fontColor: Colors.white,
                    fontSize: 18.sp,
                  ),
                ],
              ),
            ),
          ),

          // Bottom buttons section
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildCallButton(Icons.mic_off, Colors.white, () {
                  // Mute functionality
                }),
                _buildCallButton(Icons.call_end, Colors.red, () {
                  Navigator.pop(context); // End call
                }),
                _buildCallButton(Icons.volume_up, Colors.white, () {
                  // Speaker functionality
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Custom function for call action buttons
  Widget _buildCallButton(IconData icon, Color color, VoidCallback onPressed) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey[800],
      child: IconButton(
        icon: Icon(icon, color: color),
        onPressed: onPressed,
      ),
    );
  }
}
