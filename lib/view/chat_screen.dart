import 'package:astrosetu/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;

import '../modals/chat_modal.dart';
import 'chat_screen.dart';

class ChatScreen extends StatefulWidget {
  final String name;

  ChatScreen({required this.name});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Map<String, dynamic>> messages = [];
  TextEditingController _controller = TextEditingController();
  List<Chat> chat = [];
  List<InitiateCall> initiateCall = [];
  bool isChatAvailable = false;
  bool showOverlay = true;
  int countdown = 120; // 2 minutes countdown
  Timer? _timer;

  // void _sendMessage(String text) {
  //   if (text.trim().isEmpty) return;
  //   setState(() {
  //     messages.add({"text": text, "isMe": true});
  //     messages.add({"text": "Reply to: $text", "isMe": false});
  //   });
  //   _controller.clear();
  // }
  void showdilogbox(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Message Sent"),
        content: Text("Your message has been sent successfully!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }


  void sendChat() {
    if(_controller.text.toString().isNotEmpty){
      final chat = Chat(content: _controller.text, time: DateTime.now());
      socket?.emit("initiate_call", chat.toJson());
      _sendMessage(_controller.text);
      _controller.clear();
    }
  }

  void sendInitiateCall() {
    final initiateCall = InitiateCall( user_id: 'sumit ka id', astrologer_id: '7hggfhgfhgfhg777mnbvhgf', call_type: 'call');
    socket?.emit("initiate_call", initiateCall.toJson());
    // _sendMessage(_controller.text);
    // _controller.clear();
  }

  void _startChatRequest() {
    setState(() {
      messages.add({"text": "Wait for response...", "isMe": true});
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isChatAvailable = true;
        messages.add({"text": "You are available to chat with ${widget.name}", "isMe": false});

      });
    });
  }

  void _startCountdown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        _timer?.cancel();
        setState(() {
          showOverlay = false;
        });
      }
    });
  }
socket_io.Socket? socket;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startChatRequest();
       _startCountdown();
      sendInitiateCall();
      _showWelcomeDialog();

    });
    socket = socket_io.io(
      "http://192.168.1.9:5001",
      socket_io.OptionBuilder().setTransports(["websocket"]).enableAutoConnect().build(),
    );
    socket?.connect();
    setupListeners();

  }

  void setupListeners() {
    socket?.on("connect", (_) => Logger().i("Connected to server"));
    socket?.on("disconnect", (_) => Logger().i("Disconnected from server"));

    // Listen for incoming messages
    socket?.on("chat message", (data) {
      Logger().i("New message received: $data");
      setState(() {
        messages.add({"text": data, "isMe": false});
      });
    });
  }


  void _showWelcomeDialog() {
    int _timerSeconds = countdown; // Timer duration in seconds
    late Timer _timer; // Timer variable

    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dismissing by tapping outside
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Start the timer when the dialog is displayed
            _timer = Timer.periodic(Duration(seconds: 1), (timer) {
              if (_timerSeconds > 0) {
                setState(() {
                  _timerSeconds--;
                });
              } else {
                _timer.cancel(); // Stop the timer when it reaches 0
              }
            });

            return AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Display an image
                  Image.asset(
                    ImagePath.facebook, // Change this to your image asset path
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 10),

                  // Timer countdown
                  Text(
                    "Time remaining: $_timerSeconds seconds",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),

                  // Display the user's name
                  Text(
                    "Hello ${widget.name}, welcome to the chat!",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // End button
                  TextButton(
                    onPressed: () {
                      _timer.cancel(); // Cancel the timer when the button is pressed
                      Navigator.pop(context);
                    },
                    child: Text("End", style: TextStyle(fontSize: 16,color: Colors.red)),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    socket?.close();
    _timer?.cancel();
    super.dispose();
  }
  void _sendMessage(String initiate_call) {
    if (initiate_call.trim().isEmpty) return;

    setState(() {
      messages.add({"text": initiate_call, "isMe": true});
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message["isMe"] ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: message["isMe"] ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message["text"],
                      style: TextStyle(color: message["isMe"] ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          if (isChatAvailable)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send, color: Colors.blue),
                    onPressed: () => sendChat()

                        //_sendMessage(_controller.text),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

}


