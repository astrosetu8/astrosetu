import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import '../../component/mytext.dart';
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
  bool _isCallAccepted = false;
  String? astrologerId;

  @override
  void initState() {
    super.initState();
    Logger().i("User ID: ${widget.userId}");
    _handleSocketConnection();
  }

  Future<void> _handleSocketConnection() async {
    bool isConnected = await _socketService.connectWithRegister(
        userId: widget.userId, userType: 'user');
print("_handleSocketConnection $isConnected");
    if (isConnected) {
      _sendInitiateCall();
    } else {
      isReconnect();
      Logger().e("Socket connection failed. Cannot initiate call.");
    }
  }

  Future<void> isReconnect() async {
    bool isConnected = await _socketService.connect();
    if (isConnected) {
      _sendInitiateCall();
    } else {
      Logger().e("🔁 Reconnection failed.");
    }
  }


  void _listenForCallConnected() {
    _socketService.listenForCallConnected((isConnected) {
      if (isConnected) {

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              name: widget.callerName,
              userId: widget.userId,
              astrologerId: widget.astrologerId,
              callId: "",
            ),
          ),
        );
      }
    });
  }

  void _sendInitiateCall() {
    if (_isCallAccepted) {
      Logger().w("Call already initiated, waiting for connection...");
      return; // Prevent re-initiating a call if one is ongoing
    }

    _socketService.sendInitiateCall(
      userId: widget.userId,
      astrologerId: widget.astrologerId,
      callType: 'chat',
    );

    _serviceFunc();
    _listenForCallConnected();
  }

  void _serviceFunc() async {
    astrologerId = widget.astrologerId;
    if (astrologerId != null) {
      _socketService.connectWithRegister(
        userId: astrologerId.toString(),
        userType: 'astrologer',
      );
    }

    /// Listen for call rejection
    _socketService.listenForCallReject((bool isRejected, String? message) {
      print(">>>>>>>>>>>>>>> $isRejected");

      if (isRejected && mounted) {  // Ensure widget is still mounted
        Navigator.pop(context); // Go back to the previous screen

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message ?? "Call was rejected."),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );

        _socketService.disconnect();
      }
    });

    /// Listen for call rejection
    _socketService.listenForCallError((bool isRejected, String? message) {
      print(">>>>>>>>>>>>>>> $isRejected");

      if (isRejected && mounted) {  // Ensure widget is still mounted
        Navigator.pop(context); // Go back to the previous screen

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message ?? "Call was rejected."),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );

        _socketService.disconnect();
      }
    });

  }

  void _endCall() {
    _socketService.sendEndCall(callId: widget.userId);
    _socketService.disconnect();
    Logger().i("Call Ended");
    Navigator.pop(context);
  }

  // @override
  // void dispose() {
  //   _socketService.disconnect();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: MyText(
            label: widget.callerName, fontColor: Colors.white, fontSize: 20.sp),
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                        "${ImagePath.imageBaseUrl}${widget.callerImage}"),
                  ),
                  SizedBox(height: 20),
                  MyText(
                    label: _isCallAccepted ? "Connected" : "Calling...",
                    fontColor: Colors.white,
                    fontSize: 18.sp,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h),
            child: _buildCallButton(
              Icons.call_end,
              Colors.red,
              _endCall,
            ),
          ),
        ],
      ),
    );
  }

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
