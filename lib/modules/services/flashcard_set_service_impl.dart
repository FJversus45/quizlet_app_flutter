import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:quizlet_app_flutter/core/network/data_exception.dart';
import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/core/network/graphql_config.dart';
import 'package:quizlet_app_flutter/core/shared_services/services/local_cache.dart';
import 'package:quizlet_app_flutter/locator.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard.dart';
import 'package:quizlet_app_flutter/modules/model/flashcard_set.dart';
import 'package:quizlet_app_flutter/modules/services/flashcard_sets_service.dart';

class FlashcardSetServiceImpl implements FlashCardSetsService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  final cache = locator<LocalCache>();

  final String createFlashcardSetMutation = r"""
mutation Mutation($createFlashCardSetWithFlashcardsInput: FlashCardSetsInput!) {
  createFlashCardSetWithFlashcards(createFlashCardSetWithFlashcardsInput: $createFlashCardSetWithFlashcardsInput) {
    id
    numberOfCards
    subject
  }
}
    """;

  final String getAllFlashcardSetsQuery = r"""
query Flashcardsets {
  flashcardsets {
    id
    subject
    flashcards {
      createdAt
      answer
      question
    }
    numberOfCards
  }
}
    """;

  //   final String loginMutation = r"""
  // mutation Login($loginInput: LoginInput!) {
  //   login(LoginInput: $loginInput) {
  //     token
  //     user {
  //       fullname
  //       email
  //     }
  //   }
  // }
  //     """;

  @override
  Future<GeneralResponse> createFlashcardSet(
    String subject,
    List<Flashcard> card,
  ) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(createFlashcardSetMutation),
        fetchPolicy: FetchPolicy.noCache,
        // make the card input a list of maps
        variables: {
          "createFlashCardSetWithFlashcardsInput": {
            "flashcards": card
                .map((e) => {"question": e.question, "answer": e.answer})
                .toList(),

            "subject": subject,
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
      // save accesstoken
      final res = result.data?['createFlashCardSetWithFlashcards'];
      final createdFlashcardSet = FlashcardSet.fromJson(
        res as Map<String, dynamic>,
      );
      return GeneralResponse(success: true, data: createdFlashcardSet);
    } catch (e) {
      throw DataException.handleError(e);
    }
  }

  @override
  Future<GeneralResponse> getAllFlashcardSet() async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql(getAllFlashcardSetsQuery),
        fetchPolicy: FetchPolicy.noCache,
      );
      final result = await client.query(options);

      if (result.hasException) {
        return GeneralResponse(
          success: false,
          message: result.exception.toString(),
        );
      }
      final flashcardSetsData = result.data?['flashcardsets'] as List<dynamic>;
      final flashcardSets = flashcardSetsData
          .map((set) => FlashcardSet.fromJson(set as Map<String, dynamic>))
          .toList();
      return GeneralResponse(success: true, data: flashcardSets);
    } catch (e) {
      DataException.handleError(e);
      return GeneralResponse(success: false, message: e.toString());
    }
  }

  // @override
  // Future<GeneralResponse<dynamic>> signUp(User user, String password) async {
  //   try {
  //     final MutationOptions options = MutationOptions(
  //       document: gql(signUpMutation),
  //       fetchPolicy: FetchPolicy.noCache,
  //       variables: {
  //         "signUpInput": {
  //           "email": user.email,
  //           "fullname": user.fullName,
  //           "password": password,
  //           "username": user.userName,
  //         },
  //       },
  //     );
  //     final QueryResult result = await client.mutate(options);

  //     if (result.hasException) {
  //       return GeneralResponse(
  //         success: false,
  //         message: result.exception.toString(),
  //       );
  //     }
  //     final res = result.data?['signUp'];

  //     // save accesstoken
  //     final token = res['token'];

  //     await cache.saveToken(token);

  //     return GeneralResponse(success: true, data: res['user']);
  //   } catch (e) {
  //     throw DataException.handleError(e);
  //   }
  // }
}
