import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/core/shared_notifier/base_change_notifier.dart';
import 'package:quizlet_app_flutter/modules/model/user.dart';

class AuthProvider extends BaseChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<GeneralResponse> login(String email, String password) async {
    try {
      setLoading = true;
      final res = await authService.login(email, password);
      if (res.success) {
        print("Login successful: ${res.data}");
        final data = res.data as Map<String, dynamic>;

        _currentUser = User.fromJson(data);
        print("Current user: $_currentUser");
        notifyListeners();
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

  Future<GeneralResponse> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      setLoading = true;
      final res = await authService.signUp(name, email, password);
      if (res.success) {
        handleSuccess('Sign up successful');
        _currentUser = User.fromJson(res.data as Map<String, dynamic>);
        notifyListeners();
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
