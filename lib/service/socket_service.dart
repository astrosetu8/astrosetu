import 'package:logger/logger.dart';
import 'package:socket_io_client/socket_io_client.dart' as socket_io;
import '../modals/chat_modal.dart';

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  socket_io.Socket? _socket;

  SocketService._internal();

  void connect({required String userId, required String userType}) {
    _socket = socket_io.io(
      "http://192.168.1.3:5001",
      socket_io.OptionBuilder()
          .setTransports(["websocket"])
          .enableAutoConnect()
          .build(),
    );

    _socket?.on("connect", (_) {
      Logger().i("Connected to server");

      // Register user after connection is established
      registerUser(userId, userType);
    });

    _socket?.on("disconnect", (_) => Logger().i("Disconnected from server"));

    _socket?.connect();
  }

  // Register user with socket server
  void registerUser(String userId, String userType) {
    RegisterUser user = RegisterUser(user_id: userId, user_type: userType);
    _socket?.emit("register_user", user.toJson());
    Logger().i("User Registered: ${user.toJson()}");
  }

  void disconnect() {
    _socket?.disconnect();
  }

  void sendChatMessage(String message) {
    if (_socket != null) {
      _socket!.emit("chat message", message);
    }
  }

  void sendInitiateCall({required String userId, required String astrologerId, required String callType}) {
    final initiateCall = InitiateCall(user_id: userId, astrologer_id: astrologerId, call_type: callType);
    _socket?.emit("initiate_call", initiateCall.toJson());
  }

  void sendEndCall({required String callId}) {
    final acceptCall = AcceptCall(call_id: callId);
    _socket?.emit("end_call", acceptCall.toJson());
  }

  void listenForMessages(Function(dynamic) callback) {
    _socket?.on("chat message", (data) {
      Logger().i("New message received: $data");
      callback(data);
    });
  }

  void removeListeners() {
    _socket?.off("chat message");
  }

  void dispose() {
    _socket?.disconnect();
    _socket?.dispose();
  }
}
