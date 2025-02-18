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



class AcceptCall {
  final String call_id;


  // Constructor
  AcceptCall({
    required this.call_id,

  });

  // Convert JSON to Object (Factory Constructor)
  factory AcceptCall.fromJson(Map<String, dynamic> json) {
    return AcceptCall(
      call_id: json['callId'],
    );
  }

  // Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'call_id': call_id,
    };
  }


}

class RegisterUser {
  final String user_id;
  final String user_type;

  // Constructor
  RegisterUser({
    required this.user_id,
    required this.user_type,
  });

  // Convert JSON to Object (Factory Constructor)
  factory RegisterUser.fromJson(Map<String, dynamic> json) {
    return RegisterUser(
      user_id: json['user_id'],
      user_type: json['user_type'],
    );
  }

  // Convert Object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'user_type': user_type,
    };
  }
}



