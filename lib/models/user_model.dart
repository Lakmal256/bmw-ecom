class UserModel {
  String displayName;
  String email;
  String uid;
  List<String> favourite;

  UserModel({required this.displayName, required this.email, required this.uid, required this.favourite});

  factory UserModel.fromMap(Map<String, dynamic> value) {
    return UserModel(
      email: value['email'],
      displayName: value['name'],
      uid: value['uid'],
      favourite: value['favourite'] == null
          ? []
          : List<String>.from(
              value['favourite'],
            ),
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": displayName, "email": email, "uid": uid};
  }
}
