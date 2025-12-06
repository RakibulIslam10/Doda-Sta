class ChatModel {
  final String conversationId;
  final List<Participant> participants;

  ChatModel({
    required this.conversationId,
    required this.participants,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      conversationId: json['conversationId'],
      participants: (json['participants'] as List)
          .map((e) => Participant.fromJson(e))
          .toList(),
    );
  }
}

class Participant {
  final String id;
  final String name;
  final String? email;
  final String? profileImage;
  final String role;

  Participant({
    required this.id,
    required this.name,
    this.email,
    this.profileImage,
    required this.role,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImage: json['profileImage'],
      role: json['role'],
    );
  }
}
