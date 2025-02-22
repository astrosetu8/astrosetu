import 'dart:async';
import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import '../modals/chat_modal.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
    final Completer<bool> _completer = Completer<bool>(); // ✅ Persistent Completer


  socket_io.Socket? _socket;
  final Logger _logger = Logger();

  SocketService._internal();

  /// 🔥 Stream Controller for real-time messages
  final StreamController<Map<String, dynamic>> _messageStreamController = StreamController.broadcast();

  Stream<Map<String, dynamic>> get messageStream => _messageStreamController.stream;

  /// ✅ Check if socket is connected
  // bool get isConnected => _socket?.connected ?? false;

  Future<bool> connect() async {
    final completer = Completer<bool>();

    if (_socket != null && _socket!.connected) {
      _logger.i("✅ Already connected to socket");
      return true;
    }

    _socket = socket_io.io(
      "http://192.168.1.9:5001",
      socket_io.OptionBuilder()
          .setTransports(["websocket"])
          .enableAutoConnect()
          .setReconnectionAttempts(5) // Retry up to 5 times
          .build(),
    );

    _socket?.on("connect", (_) {
      _logger.i("✅ Connected to server");
      if (!completer.isCompleted) {
        completer.complete(true);
      }
    });

    _socket?.on("connect_error", (error) {
      _logger.e("⛔ Connection error: $error");
      if (!completer.isCompleted) {
        completer.complete(false);
      }
    });

    _socket?.on("disconnect", (_) {
      _logger.w("⚠️ Disconnected from server");
    });

    _socket?.on("receive_message", (data) {
      _logger.i("📩 Message received: $data");

      // ✅ Prevent adding to a closed stream
      if (!_messageStreamController.isClosed) {
        _messageStreamController.add(data);
      } else {
        _logger.w("⚠️ StreamController is closed, ignoring message.");
      }
    });

    _socket?.connect();
    return completer.future;
  }


  /// 📌 Connect with user registration
  Future<bool> connectWithRegister({required String userId, required String userType}) async {
   // _completer = Completer<bool>(); // Reset the completer for a new connection

    _socket = socket_io.io(
      "http://192.168.1.8:5001",
      socket_io.OptionBuilder()
          .setTransports(["websocket"])
          .enableAutoConnect()
          .build(),
    );

    _socket?.on("connect", (_) {
      Logger().i("✅ Connected to server");
      registerUser(userId, userType);
      if (!_completer.isCompleted) _completer.complete(true);
    });

    _socket?.on("connect_error", (error) {
      Logger().e("⛔ Connection error: $error");
      if (!_completer.isCompleted) _completer.complete(false);
    });

    _socket?.connect();
    return _completer.future;
  }

  /// 🔄 Register user with socket server
  void registerUser(String userId, String userType) {
    RegisterUser user = RegisterUser(user_id: userId, user_type: userType);
    _socket?.emit("register_user", user.toJson());
    Logger().i("🆔 User Registered: ${user.toJson()}");
  }

  /// 🚪 Disconnect & clean up

  void disconnect() {
    if (_socket != null && _socket!.connected) {
      _socket!.disconnect();
      _socket = null;
      Logger().w("⚠️ Socket disconnected before reconnecting.");
    }
  }


  /// 📨 Send chat message
  void sendChatMessage(String message) {
    if (_socket != null && _socket!.connected) {
      _socket!.emit("chat message", message);
      _logger.i("📤 Chat Message Sent: $message");
    } else {
      _logger.e("⛔ Cannot send message. Socket not connected.");
    }
  }

  /// 📞 Initiate Call
  void sendInitiateCall({required String userId, required String astrologerId, required String callType}) {
    final initiateCall = InitiateCall(user_id: userId, astrologer_id: astrologerId, call_type: callType);
    _socket?.emit("initiate_call", initiateCall.toJson());
    _logger.i("📞 Call Initiated: ${initiateCall.toJson()}");
  }

  /// 📴 End Call
  void sendEndCall({required String callId}) {
    final acceptCall = AcceptCall(call_id: callId);
    _socket?.emit("end_call", acceptCall.toJson());
    //_removeListeners();
    _logger.i("📴 Call Ended: ${acceptCall.toJson()}");
  }

  /// ✉️ Send Message with Reconnection Handling
  Future<void> sendMessage({required String userId, required String astrologerId, required String message}) async {
    if (_socket == null || !_socket!.connected) {
      _logger.e("⛔ Socket not connected. Attempting to reconnect...");

      bool isReconnected = await connect();
      if (!isReconnected) {
        _logger.e("❌ Reconnection failed. Message not sent.");
        return;
      }
    }

    _socket?.emit("send_message", {
      "user_id": userId,
      "astrologer_id": astrologerId,
      "message": message,
      "sender": "user",
    });

    _logger.i("📩 Message Sent: $message");
  }

  /// ✅ Listen for incoming messages
  void listenForMessages(Function(dynamic) callback) {
    _socket?.on("receive_message", (data) {
      _logger.i("📨 New message received: $data");
      callback(data);
    });
  }

  /// 📡 Listen for call connection
  void listenForCallConnected(Function(bool) onCallConnected) {
    _socket?.on("call_connected", (data) {
      _logger.i("🔗 Call Connected: $data");
      onCallConnected(false);
    });
  }
  /// 📡 Listen for call connection
  void listenForCallEnded(Function(dynamic) onCallConnected) {
    _socket?.on("call_ended", (data) {
      _logger.i("🔗 Call Connected: $data");
      onCallConnected(true);
    });
  }

  void listenForCallReject(Function(bool, String?) onCallRejected) {
    _socket?.on("call_rejected", (data) {
      _logger.i("🚫 Call Rejected: $data");

      // Assuming `data` contains a rejection message
      String? message = data['message']; // Modify based on actual API response

      onCallRejected(true, message);
    });
  }
  void listenForCallError(Function(bool, String?) onCallRejected) {
    _socket?.on("call_error", (data) {
      _logger.i("🚫 Call Rejected: $data");

      // Assuming `data` contains a rejection message
      String? message = data['message']; // Modify based on actual API response

      onCallRejected(true, message);
    });
  }



  // /// 🚫 Remove listeners to prevent memory leaks
  // void _removeListeners() {
  //   _socket?.off("chat message");
  //   _socket?.off("receive_message");
  //   _socket?.off("call_connected");
  // }

  /// 🛑 Dispose of socket properly
  void dispose() {
    // _removeListeners();
    _socket?.disconnect();
    _socket?.dispose();
    _logger.w("🛑 Socket Service Disposed.");
  }






}


