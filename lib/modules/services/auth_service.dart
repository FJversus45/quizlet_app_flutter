import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/modules/model/user.dart';

abstract class AuthService {
  Future<GeneralResponse> login(String email, String password);

  Future<GeneralResponse> signUp(User user, String password);
}
