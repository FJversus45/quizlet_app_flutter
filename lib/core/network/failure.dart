abstract class Failure implements Exception {
  const Failure(this.message);
  final String message;
}

class SignInFailure extends Failure {
  SignInFailure(super.message);
}

class ApiFailure extends Failure {
  ApiFailure(super.message);
}

class SignUpFailure implements Failure {
  @override
  final String message;
  const SignUpFailure(this.message);
}
