// import 'package:flutter/material.dart';
// import 'package:manager_app/model_message.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/io.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class MessageList extends StatefulWidget {
//   const MessageList({super.key});

//   @override
//   _MessageListState createState() => _MessageListState();
// }

// class _MessageListState extends State<MessageList> {
//   final TextEditingController _textController = TextEditingController();
//   final List<Message> _messages = [];
//   WebSocketChannel? _channel;

//   @override
//   void initState() {
//     super.initState();

//     try {
//       // Create a WebSocket connection to the server
//       _channel = IOWebSocketChannel.connect('ws://localhost:7264/chat');

//       // Listen to incoming messages from the server
//       _channel?.stream.listen((event) {
//         final message = Message.fromJson(jsonDecode(event));
//         setState(() {
//           _messages.add(message);
//         });
//       });

//       // Fetch the initial list of messages from the API
//       _fetchMessages();
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   void _fetchMessages() async {
//     final response =
//         await http.get(Uri.parse('https://localhost:7264/api/Messages'));
//     if (response.statusCode == 200) {
//       final messages = (jsonDecode(response.body) as List<dynamic>)
//           .map((dynamic json) => Message.fromJson(json))
//           .toList();
//       setState(() {
//         _messages.addAll(messages);
//       });
//     }
//   }

//   void _sendMessage(String text) {
//     final message = Message(
//       id: 0,
//       senderId: 1, // Replace with the ID of the logged-in user
//       receiverId: 2, // Replace with the ID of the recipient
//       text: text,
//       sentAt: DateTime.now(),
//     );

//     // Send the message to the server via the WebSocket connection
//     _channel?.sink.add(jsonEncode(
//       json.encode({
//         'senderId': 1,
//         'receiverId': 2,
//         'text': text,
//         'sentAt': DateTime.now().toIso8601String(),
//       }),
//     ));

//     setState(() {
//       _messages.add(message);
//     });

//     _textController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Messages'),
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: _messages.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final message = _messages[index];
//                 final time = DateFormat('hh:mm a').format(message.sentAt);
//                 return ListTile(
//                   title: Text(message.text),
//                   subtitle: Text(time),
//                   trailing: Text(message.senderId.toString()),
//                 );
//               },
//             ),
//           ),
//           const Divider(height: 1.0),
//           Container(
//             decoration: BoxDecoration(color: Theme.of(context).cardColor),
//             child: Row(
//               children: <Widget>[
//                 Expanded(
//                   child: TextField(
//                     controller: _textController,
//                     onSubmitted: _sendMessage,
//                     decoration: const InputDecoration.collapsed(
//                         hintText: 'Send a message'),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: () => _sendMessage(_textController.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _channel?.sink.close();
//     super.dispose();
//   }
// }
