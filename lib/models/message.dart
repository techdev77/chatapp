class Message {
  Message({
      String? sendTo, 
      String? updatedAt,
      String? msgImg, 
      String? readStatus, 
      String? createdAt,
      String? message, 
      String? senderId,}){
    _sendTo = sendTo;
    _updatedAt = updatedAt;
    _msgImg = msgImg;
    _readStatus = readStatus;
    _createdAt = createdAt;
    _message = message;
    _senderId = senderId;
}

  Message.fromJson(dynamic json) {
    _sendTo = json['send_to'];
    _updatedAt = json['updated_at'].toString();
    _msgImg = json['msg_img'];
    _readStatus = json['read_status'];
    _createdAt = json['created_at'].toString();
    _message = json['message'];
    _senderId = json['sender_id'];
  }
  String? _sendTo;
  String? _updatedAt;
  String? _msgImg;
  String? _readStatus;
  String? _createdAt;
  String? _message;
  String? _senderId;
// Message copyWith({  String? sendTo,
//   UpdatedAt? updatedAt,
//   String? msgImg,
//   String? readStatus,
//   CreatedAt? createdAt,
//   String? message,
//   String? senderId,
// }) => Message(  sendTo: sendTo ?? _sendTo,
//   updatedAt: updatedAt ?? _updatedAt,
//   msgImg: msgImg ?? _msgImg,
//   readStatus: readStatus ?? _readStatus,
//   createdAt: createdAt ?? _createdAt,
//   message: message ?? _message,
//   senderId: senderId ?? _senderId,
// );
  String? get sendTo => _sendTo;
  String? get updatedAt => _updatedAt;
  String? get msgImg => _msgImg;
  String? get readStatus => _readStatus;
  String? get createdAt => _createdAt;
  String? get message => _message;
  String? get senderId => _senderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['send_to'] = _sendTo;
    if (_updatedAt != null) {
      map['updated_at'] = _updatedAt;
    }
    map['msg_img'] = _msgImg;
    map['read_status'] = _readStatus;
    if (_createdAt != null) {
      map['created_at'] = _createdAt;
    }
    map['message'] = _message;
    map['sender_id'] = _senderId;
    return map;
  }

}

class CreatedAt {
  CreatedAt({
      num? seconds, 
      num? nanoseconds,}){
    _seconds = seconds;
    _nanoseconds = nanoseconds;
}

  CreatedAt.fromJson(dynamic json) {
    _seconds = json['seconds'];
    _nanoseconds = json['nanoseconds'];
  }
  num? _seconds;
  num? _nanoseconds;
CreatedAt copyWith({  num? seconds,
  num? nanoseconds,
}) => CreatedAt(  seconds: seconds ?? _seconds,
  nanoseconds: nanoseconds ?? _nanoseconds,
);
  num? get seconds => _seconds;
  num? get nanoseconds => _nanoseconds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seconds'] = _seconds;
    map['nanoseconds'] = _nanoseconds;
    return map;
  }

}

class UpdatedAt {
  UpdatedAt({
      num? seconds, 
      num? nanoseconds,}){
    _seconds = seconds;
    _nanoseconds = nanoseconds;
}

  UpdatedAt.fromJson(dynamic json) {
    _seconds = json['seconds'];
    _nanoseconds = json['nanoseconds'];
  }
  num? _seconds;
  num? _nanoseconds;
UpdatedAt copyWith({  num? seconds,
  num? nanoseconds,
}) => UpdatedAt(  seconds: seconds ?? _seconds,
  nanoseconds: nanoseconds ?? _nanoseconds,
);
  num? get seconds => _seconds;
  num? get nanoseconds => _nanoseconds;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['seconds'] = _seconds;
    map['nanoseconds'] = _nanoseconds;
    return map;
  }

}