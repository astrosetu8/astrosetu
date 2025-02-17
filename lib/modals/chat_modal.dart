import 'dart:convert';

class Chat {
  final String content;
  // final String userId;
  // final String callType;
  final DateTime time;

  const Chat({
    required this.content,
    required this.time,
    // required this.userId,
    // required this.callType,
  });

  // Convert from JSON (Deserialization)
  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      content: json['content'],
      // userId: json['userId'],
      // callType: json['callType'],
      time: DateTime.parse(json['time']),
    );
  }

  // Convert to JSON (Serialization)
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      // 'userId': userId,
      // 'callType': callType,
      'time': time.toIso8601String(),
    };
  }
}


class InitiateCall {
  final String user_id;
  final String astrologer_id;
  final String call_type;

  // Constructor
  InitiateCall({
    required this.user_id,
    required this.astrologer_id,
    required this.call_type,
  });

  // Convert JSON to Object (Factory Constructor)
  factory InitiateCall.fromJson(Map<String, dynamic> json) {
    return InitiateCall(
      user_id: json['userId'],
      astrologer_id: json['astroId'],
      call_type: json['callType'],
    );
  }

  // Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'astrologer_id': astrologer_id,
      'call_type': call_type,
    };
  }


}

