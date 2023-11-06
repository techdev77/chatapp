class ChatModel {
  ChatModel();

  ChatModel.fromJson(dynamic json) {
    sendTo = json['send_to'].toString();
    createdAt = json['created_at'].toString();
    message = json['message'].toString();
    senderId = json['sender_id'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
  }

  String? sendTo;
  String? createdAt;
  String? message;
  String? senderId;
  String? name;
  String? email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['send_to'] = sendTo;
    map['created_at'] = createdAt;
    map['message'] = message;
    map['sender_id'] = senderId;
    map['name'] = name;
    map['email'] = email;
    return map;
  }
}