import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/core/shared_notifier/base_change_notifier.dart';
import 'package:quizlet_app_flutter/modules/model/user.dart';

class AuthProvider extends BaseChangeNotifier {
  Future<GeneralResponse> login(String email, String password) async {
    try {
      setLoading = true;
      final res = await authService.login(email, password);
      if (res.success) {
        handleSuccess('Login successful');
        return GeneralResponse(success: true, data: res.data);
      } else {
        handleError(res.message);
        return GeneralResponse(success: false, message: res.message);
      }
    } catch (e) {
      handleError(e.toString());
      return GeneralResponse(success: false, message: e.toString());
    }
  }

  Future<GeneralResponse> signUp(User user, String password) async {
    try {
      setLoading = true;
      final res = await authService.signUp(user, password);
      if (res.success) {
        handleSuccess('Sign up successful');
        return GeneralResponse(success: true, data: res.data);
      } else {
        handleError(res.message);
        return GeneralResponse(success: false, message: res.message);
      }
    } catch (e) {
      handleError(e.toString());
      return GeneralResponse(success: false, message: e.toString());
    }
  }
}

// were not done
