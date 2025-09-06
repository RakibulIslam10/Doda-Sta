class MessageModel {
  final String? text;
  final String? imageUrl;
  final bool isMe;
  final String? time;

  MessageModel({this.text, this.imageUrl, required this.isMe, this.time});
}
