import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:quizlet_app_flutter/core/network/data_exception.dart';
import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/core/network/graphql_config.dart';
import 'package:quizlet_app_flutter/core/shared_services/services/local_cache.dart';
import 'package:quizlet_app_flutter/locator.dart';
import 'package:quizlet_app_flutter/modules/model/user.dart';
import 'package:quizlet_app_flutter/modules/services/auth_service.dart';

class AuthServiceImpl implements AuthService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  final cache = locator<LocalCache>();

  final String loginMutation = r"""
mutation Login($loginInput: LoginInput!) {
  login(LoginInput: $loginInput) {
    token
    user {
      fullname
      email
    }
  }
}
    """;

  final String signUpMutation = r"""
    mutation SignUp($signUpInput: SignUpInput!) {
  signUp(SignUpInput: $signUpInput) {
    token
    user {
      id
      fullname
      password
      email
    }
  }
}""";

  @override
  Future<GeneralResponse<dynamic>> login(String email, String password) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(loginMutation),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          "loginInput": {"email": email, "password": password},
        },
      );
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        return GeneralResponse(
          success: false,
          message: result.exception.toString(),
        );
      }
      // save accesstoken
      final res = result.data?['login'];
      final token = res['token'] as String;
      await cache.saveToken(token);
      return GeneralResponse(success: true, data: res['user']);
    } catch (e) {
      throw DataException.handleError(e);
    }
  }

  @override
  Future<GeneralResponse<dynamic>> signUp(User user, String password) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(signUpMutation),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          "signUpInput": {
            "email": user.email,
            "fullname": user.fullName,
            "password": password,
            "username": user.userName,
          },
        },
      );
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        return GeneralResponse(
          success: false,
          message: result.exception.toString(),
        );
      }
      final res = result.data?['signUp'];

      // save accesstoken
      final token = res['token'];

      await cache.saveToken(token);

      return GeneralResponse(success: true, data: res['user']);
    } catch (e) {
      throw DataException.handleError(e);
    }
  }
}
