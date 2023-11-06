class UserModel {
  UserModel();

  UserModel.fromJson(dynamic json) {
    name = json['name'].toString();
    email = json['email'].toString();
    profilePic = json['profile_pic'].toString();
    createdAt = json['created_at'].toString();
  }

  String? name;
  String? email;
  String? profilePic;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['profile_pic'] = profilePic;
    map['created_at'] = createdAt;
    return map;
  }
}