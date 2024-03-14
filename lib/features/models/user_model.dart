class UserModel {
  String id;
  String email;
  String userName;
  bool isVerified;
  String phone;
  UserModel(
      {required this.id,
      required this.email,
      required this.userName,
      this.isVerified = false,
      this.phone = ''});

  UserModel.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          email: json['email'],
          userName: json['userName'],
          isVerified: json['isVerified'],
          phone: json['phone'],
        );
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'isVerified': isVerified,
      'phone': phone,
    };
  }
}
