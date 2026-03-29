import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? id;
  final String fullName;
  final String? userName;
  final String? email;

  const User({this.id, required this.fullName, this.userName, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as String?,
      fullName: json["fullname"] as String,
      userName: json["username"] as String?,
      email: json["email"] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'fullname': fullName,
      'username': userName,
    };
  }

  @override
  List<Object?> get props => [id, email, fullName, userName];
}
