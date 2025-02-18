import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import '../../component/mytext.dart';
import '../../modals/chat_modal.dart';
import '../../service/socket_service.dart';
import '../../utils/image.dart';
import '../chat_screen.dart';

class CallScreen extends StatefulWidget {
  final String callerName;
  final String callerImage;
  final String callType;
  final String userId;
  final String astrologerId;
  final String phone;

  CallScreen({
    required this.callerName,
    required this.callerImage,
    required this.callType,
    required this.phone,
    required this.userId,
    required this.astrologerId,
  });

  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final SocketService _socketService = SocketService();

  @override
  void initState() {
    super.initState();
    print("user id >>>${widget.userId}");
    _socketService.connect(userId: widget.userId, userType: 'user');
    sendInitiateCall();
  }

  void _acceptCall() {
    _socketService.sendInitiateCall;
    Logger().i("Call Accepted");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(name: widget.callerName,

        //    callId: widget.callId
        ),
      ),
    );
  }

  void sendInitiateCall() {
    _socketService.sendInitiateCall(userId: widget.userId, astrologerId: widget.astrologerId, callType: 'chat');

    // _sendMessage(_controller.text);
    // _controller.clear();
  }

  void _endCall() {
    _socketService.sendEndCall(callId: widget.userId);
    Logger().i("Call Ended");
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      // App Bar with caller's name
      appBar: AppBar(
        title: MyText(label: widget.callerName, fontColor: Colors.white, fontSize: 20.sp),
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
                    backgroundImage: NetworkImage("${ImagePath.imageBaseUrl}${widget.callerImage}"),
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
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.primaryDelta! < 0) {
                  // Swipe Up: Accept Call
                  _acceptCall();
                } else if (details.primaryDelta! > 0) {
                  // Swipe Down: End Call
                  _endCall();
                }
              },
              child: _buildCallButton(
                Icons.call,
                Colors.red,
                    () {},
              ),
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
