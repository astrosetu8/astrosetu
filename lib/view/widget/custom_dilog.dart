import 'dart:async';
import 'package:flutter/material.dart';

class CountdownDialog extends StatefulWidget {
  final String name;
    var countdownController;

  CountdownDialog({required this.name, required this.countdownController});

  @override
  _CountdownDialogState createState() => _CountdownDialogState();
}

class _CountdownDialogState extends State<CountdownDialog> {
  @override
  void initState() {
    super.initState();
    widget.countdownController.onTick = () {
      setState(() {}); // Update UI
    };
    widget.countdownController.onComplete = () {
      Navigator.of(context).pop(); // Auto-close when countdown ends
    };
    widget.countdownController.startTimer();
  }

  @override
  void dispose() {
    widget.countdownController.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage("https://via.placeholder.com/150"),
          ),
          SizedBox(height: 10),
          Text(widget.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text("Time Left: ${widget.countdownController.timeLeft} sec",
              style: TextStyle(fontSize: 16, color: Colors.red)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              widget.countdownController.stopTimer();
              Navigator.of(context).pop();
            },
            child: Text("End"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red, foregroundColor: Colors.white),
          ),
        ],
      ),
    );
  }
}
