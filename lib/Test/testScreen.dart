// import 'package:flutter/material.dart';
// import 'package:manager_app/model_message.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:web_socket_channel/io.dart';
// import 'package:web_socket_channel/web_socket_channel.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({super.key});

//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final WebSocketChannel _channel =
//       IOWebSocketChannel.connect('ws://localhost:7264/chat');

//   final String apiUrl =
//       'http://localhost:7264/api/Messages?senderId=1&receiverId=2'; // Replace with your API URL

//   List<Message> _messages = [];
//   late Stream<List<Message>> _messagesStream;

//   @override
//   void initState() {
//     super.initState();
//     _channel.stream.listen((dynamic data) {
//       // Listen to incoming messages from the server
//       setState(() {
//         _messages.add(Message.fromJson(
//             data)); // Convert received data to Message object and add to the list
//       });
//     });
//   }

//   final _messageController = TextEditingController();
//   // void _fetchAndStreamData() async {
//   //   // Send HTTP GET request to fetch data
//   //   http.Response response = await http.get(Uri.parse(
//   //       'https://localhost:7264/api/Messages?senderId=1&receiverId=2'));

//   //   if (response.statusCode == 200) {
//   //     // If the response is successful, create a WebSocket channel

//   //     // Create a Stream from the WebSocket channel and set it to _stream
//   //     _stream = _channel.stream;

//   //     // Call setState to trigger a rebuild with the new data
//   //     setState(() {});
//   //   } else {
//   //     // Handle error response
//   //     print('Error fetching data: ${response.statusCode}');
//   //   }
//   // }

//   @override
//   void dispose() {
//     _messageController.dispose();
//     _channel.sink.close();
//     super.dispose();
//   }

//   // Stream<List<Message>> getMessagesStream() async* {
//   //   while (true) {
//   //     await Future.delayed(
//   //         const Duration(milliseconds: 100)); // Fetch data every 5 seconds

//   //     final response = await http.get(Uri.parse(
//   //         'https://localhost:7264/api/Messages?senderId=1&receiverId=2'));
//   //     print(response.body);

//   //     if (response.statusCode == 200) {
//   //       List<dynamic> jsonMessages = jsonDecode(response.body);
//   //       List<Message> messages =
//   //           jsonMessages.map((json) => Message.fromJson(json)).toList();
//   //       yield messages;
//   //     } else {
//   //       throw Exception('Failed to load messages');
//   //     }
//   //   }
//   // }

//   // Stream<List<Message>> getMessages() async* {
//   //   final response = await http.get(Uri.parse(
//   //       'https://localhost:7264/api/Messages?senderId=1&receiverId=2'));
//   //   print(response.body);

//   //   if (response.statusCode == 200) {
//   //     List<dynamic> jsonMessages = jsonDecode(response.body);
//   //     yield jsonMessages.map((json) => Message.fromJson(json)).toList();
//   //   } else {
//   //     throw Exception('Failed to load messages');
//   //   }
//   // }

//   Future<void> sendMessage(String text) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://localhost:7264/api/Messages'),
//         body: json.encode({
//           'senderId': 1,
//           'receiverId': 2,
//           'text': text,
//           'sentAt': DateTime.now().toIso8601String(),
//         }),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 201) {
//         final message = Message.fromJson(json.decode(response.body));
//         _messageController.clear();
//         _messages.add(message);
//         setState(() {});
//       } else {
//         print('Failed to send message. Status code: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error sending message: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey.shade300,
//       appBar: AppBar(title: const Text('Chat')),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<Message>>(
//               stream: _messagesStream,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   _messages = snapshot.data!.reversed.toList();
//                   return ListView.builder(
//                     reverse: true,
//                     itemCount: _messages.length,
//                     itemBuilder: (context, index) {
//                       Message message = _messages[index];
//                       return Container(
//                         width: double.infinity,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 10, vertical: 7),
//                         alignment: message.senderId == 1
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             AnimatedContainer(
//                               curve: Curves.easeInOut,
//                               duration: const Duration(milliseconds: 100),
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 13, vertical: 7),
//                               decoration: BoxDecoration(
//                                   color: message.senderId == 1
//                                       ? Colors.teal
//                                       : Colors.indigo,
//                                   borderRadius: BorderRadius.circular(5)),
//                               child: Text(
//                                 message.text,
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                 ),
//                               ),
//                             ),
//                             Text(
//                               '${message.sentAt.hour}:${message.sentAt.minute}',
//                               style: const TextStyle(fontSize: 11),
//                             ),
//                           ],
//                         ),
//                       );

//                       // ListTile(
//                       //   title: Text(message.text),
//                       //   subtitle: Text('Sent at ${message.sentAt}'),
//                       // );
//                     },
//                   );
//                 } else if (snapshot.hasError) {
//                   return Text('Error: ${snapshot.error}');
//                 } else {
//                   return const Center(child: CircularProgressIndicator());
//                 }
//               },
//             ),
//           ),
//           Container(
//             color: Colors.white,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: TextField(
//                       controller: _messageController,
//                       onSubmitted: (val) =>
//                           sendMessage(_messageController.text),
//                       decoration: const InputDecoration(
//                         hintText: 'Type your message...',
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () => sendMessage(_messageController.text),
//                   icon: const Icon(Icons.send),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
