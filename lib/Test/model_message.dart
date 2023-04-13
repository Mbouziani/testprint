class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final String text;
  final DateTime sentAt;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.sentAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      text: json['text'],
      sentAt: DateTime.parse(json['sentAt']),
    );
  }
}
