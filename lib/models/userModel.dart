class UserModel {
  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.phoneNumber,
    required this.isOnline,
    required this.groupId,
  });

  String name;
  String uid;
  String profilePic;
  String phoneNumber;
  bool isOnline;
  List<String> groupId;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        name: json["name"],
        uid: json["uid"],
        profilePic: json["profilePic"],
        phoneNumber: json["phoneNumber"],
        isOnline: json["isOnline"],
        groupId: List<String>.from(json["groupId"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "uid": uid,
        "profilePic": profilePic,
        "phoneNumber": phoneNumber,
        "isOnline": isOnline,
        "groupId": List<dynamic>.from(groupId.map((x) => x)),
      };
}
