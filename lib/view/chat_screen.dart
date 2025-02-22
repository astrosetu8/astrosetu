import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';
import '../component/mytext.dart';
import '../service/socket_service.dart';

class ChatScreen extends StatefulWidget {
  final String name;
  final String userId;
  final String astrologerId;
  final String callId;

  ChatScreen({required this.name, required this.userId, required this.astrologerId,required this.callId,});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];  // Store messages

  TextEditingController _controller = TextEditingController();
  final SocketService _socketService = SocketService(); // Using SocketService



  @override
  void initState() {
    super.initState();

    // Connect to socket
    _socketService.connect().then((isConnected) {
      if (isConnected) {
        _socketService.listenForMessages((data) {
          if (mounted) {
            setState(() {
              messages.add({"text": data["message"], "isMe": false});
            });
          }
        });

        // 📡 Listen for call rejection
        _socketService.listenForCallEnded((callEnded) {
          if (callEnded) {
            if (mounted) {
              print("data for read $callEnded");
              _showCallEndedDialog();
            }
          }
        });
      } else {
        Logger().e("❌ Could not connect to the socket.");
      }
    });
  }

  /// Show dialog when the call ends
  void _showCallEndedDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (context) {
        return AlertDialog(
          title: Text("Call Ended"),
          content: Text("The other side has ended the call."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }


  void sendChat() {
    if (_controller.text.trim().isNotEmpty) {
      String message = _controller.text.trim();
      _socketService.sendMessage(
        userId: widget.userId,
        astrologerId: widget.astrologerId,
        message: message,
      );

      setState(() {
        messages.add({"text": message, "isMe": true});
      });

      _controller.clear();
    }
  }


  void _endCall() {
    _socketService.sendEndCall(callId: widget.callId);
    _socketService.disconnect();
    Logger().i("Reject Ended");
    //Navigator.pop(context);
  }
  // @override
  // void dispose() {
  //   _socketService.disconnect();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF8F2),
      appBar: AppBar(
        backgroundColor: Color(0xffFFF8F2),
        title: MyText( label: widget.name,fontWeight: FontWeight.w500,fontSize: 16.sp,),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white,
              child: IconButton(color: Colors.white,
                  onPressed: (){
                    _endCall();

                  }, icon:   Icon(Icons.exit_to_app_outlined,color: Colors.black,)),
            ),
          )

        ],
      ),
      body: Column(
        children: [
          Expanded(
              child:
              StreamBuilder<Map<String, dynamic>>(
                stream: _socketService.messageStream,  // Listen to message stream
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    messages.add({
                      "text": snapshot.data!["message"],
                      "isMe": false,  // Assuming this is a received message
                    });
                  }

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return Align(
                        alignment: message["isMe"] ? Alignment.centerRight : Alignment.centerLeft,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7, // Max 70% of screen width
                          ),
                          child: IntrinsicWidth( // Ensures width adjusts based on content
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                color: message["isMe"] ? Colors.grey[300] : Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomLeft: message["isMe"] ? Radius.circular(20) : Radius.circular(0),
                                  bottomRight: message["isMe"] ? Radius.circular(0) : Radius.circular(20),
                                ),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black12,
                                //     blurRadius: 2,
                                //     offset: Offset(0, 2),
                                //   ),
                                // ],
                              ),
                              child: Row(
                                //  crossAxisSize: CrossAxisSize.min, // Shrinks to fit content
                                crossAxisAlignment: CrossAxisAlignment.end, // Align text properly
                                children: [
                                  Expanded(
                                    child: MyText(
                                      label: message["text"],
                                      fontColor: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 4), // Space between text and timestamp
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Text(
                                      _formatTime(DateTime.now()), // Function to format time
                                      style: TextStyle(
                                        fontSize: 10.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      )




                      ;
                    },
                  );
                },
              )

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.blue),
                  onPressed: sendChat,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}"; // HH:mm format
  }

}