import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({this.id, this.fullName, this.userName, this.email});
  final String? id;
  final String? fullName;
  final String? userName;
  final String? email;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as String?,
      fullName: json["fullName"] as String?,
      userName: json["userName"] as String?,
      email: json["email"] as String?,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
