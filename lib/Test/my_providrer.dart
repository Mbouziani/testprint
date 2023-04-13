// import 'package:flutter/material.dart';
// import 'package:manager_app/model_message.dart';
// import 'package:web_socket_channel/io.dart';

// class WebSocketService extends ChangeNotifier {
//   final _messageController = TextEditingController();

//   final List<Message> _messages = [];
//   List<Message> get messageList => _messages;

//   final String apiUrl = 'wss://localhost:7264'; // Update with your API URL
//   late IOWebSocketChannel _channel;

//   Stream<dynamic> get stream => _channel.stream;

//   void connect() {
//     _channel = IOWebSocketChannel.connect(apiUrl);
//   }

//   void disconnect() {
//     _channel.sink.close();
//   }
// }
