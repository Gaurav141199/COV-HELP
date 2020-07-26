class User {
  String uid;
  String name;
  String email;
  String profilePhoto;
  String phone;
  String blood;

  User(
      {this.uid,
      this.name,
      this.email,
      this.profilePhoto,
      this.blood,
      this.phone});

  Map toMap(User user) {
    var data = Map<String, dynamic>();
    data["uid"] = user.uid;
    data['name'] = user.name;
    data['email'] = user.email;
    data['blood'] = user.blood;
    data["phone"] = user.phone;
    return data;
  }

  User.fromMap(Map<String, dynamic> mapData) {
    this.uid = mapData['uid'];
    this.name = mapData['name'];
    this.email = mapData['email'];
    this.blood = mapData["blood"];
    this.phone = mapData["phone"];

    this.profilePhoto = mapData['profile_photo'];
  }
}

User user1 = User();
