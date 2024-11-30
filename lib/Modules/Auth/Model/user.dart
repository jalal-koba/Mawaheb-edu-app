class UserModel {
  Data? data;
  String? message;

  UserModel({required this.data, required this.message});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        message: json['message'],
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
      );
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  final String username;
  final String fullName;
  final String residencePlace;
  final String birthdayDate;

  final String email;
  final String phoneNumber;
  final int id;
  final String? token;
  final String? image;

  User(
      {required this.username,
      required this.fullName,
      required this.residencePlace,
      required this.birthdayDate,
      required this.email,
      required this.phoneNumber,
      required this.id,
      required this.token,
      required this.image});

  factory User.fromJson(Map json) => User(
      birthdayDate: json['birth_date'] ?? "",
      fullName: json['full_name'],
      residencePlace: json['location'] ?? "",
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      phoneNumber: json['phone_number'],
      id: json['id'],
      token: json['token'],
      image: json['image']);
}
