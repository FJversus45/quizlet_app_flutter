import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:quizlet_app_flutter/core/network/data_exception.dart';
import 'package:quizlet_app_flutter/core/network/general_response.dart';
import 'package:quizlet_app_flutter/core/network/graphql_config.dart';
import 'package:quizlet_app_flutter/core/shared_services/services/local_cache.dart';
import 'package:quizlet_app_flutter/locator.dart';
import 'package:quizlet_app_flutter/modules/model/lobby_model.dart';

import 'package:quizlet_app_flutter/modules/services/lobby_service.dart';

class LobbyServiceImpl implements LobbyService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  final cache = locator<LocalCache>();

  final String createLobbyMutation = r"""
mutation Mutation($createLobbyInput: CreateLobbyInput!) {
  createLobby(createLobbyInput: $createLobbyInput) {
    id
    lobbyCode
    lobbyStatus
    participatingPlayers {
      fullname
      id
      username
    }
    leaderboard {
      entries {
        id
        score
        rank
        player {
          fullname
          id
          username
        }
        streak
        correctAnswers
        incorrectAnswers
      }
    }
    createdBy {
      id
      fullname
      username
    }
    flashCardSet {
      flashcards {
        answer
        question
      }
      subject
      numberOfCards
      id
    }
  }
}
    """;

  final String startLobbyMutation = r"""
mutation Mutation($lobbyCode: String!) {
  startLobby(lobbyCode: $lobbyCode) {
    
    lobbyCode
    flashCardSet {
      id
      numberOfCards
      subject
      flashcards {
        answer
        question
      }
    }
  }
}    """;

  final String joinLobbyMutation = r"""
   mutation Mutation($joinLobbyInput: JoinLobbyInput!) {
  joinLobby(joinLobbyInput: $joinLobbyInput) {
    participatingPlayers {
      fullname
      username
      id
    }
    leaderboard {
      entries {
        player {
          fullname
          id
          username
        }
        rank
        score
        correctAnswers
        incorrectAnswers
        streak
      }
    }
    lobbyCode
    createdBy {
      fullname
      id
      username
    }
    lobbyStatus
    id
    flashCardSet {
      flashcards {
        answer
        question
      }
      numberOfCards
      subject
      id
    }
  }
}""";

  final String watchLobbySubscription = r"""
subscription LeaderboardUpdated($lobbyCode: String!) {
  leaderboardUpdated(lobbyCode: $lobbyCode) {
    entries {
    player {
      fullname
      id
      username
    }
      correctAnswers
      id
      incorrectAnswers
      rank
      score
      streak
      lobbyId
      updatedAt
    }
    id
    lobbyCode
    lobbyId
    lobbyStatus
    updatedAt
  }
}
    """;

  final String submitAnswerMutation = r"""
mutation Mutation($submitAnswerInput: SubmitAnswerInput!) {
  submitAnswer(submitAnswerInput: $submitAnswerInput) {
    scoreDelta
  }
}
    """;

  @override
  Future<GeneralResponse<dynamic>> createLobby(String flashcardSetId) async {
    print("reached here");
    try {
      final MutationOptions options = MutationOptions(
        document: gql(createLobbyMutation),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          "createLobbyInput": {"flashCardSetId": flashcardSetId},
        },
      );
      final QueryResult result = await client.mutate(options);
      print("Create lobby result: $result");

      if (result.hasException) {
        print("has exception");
        return GeneralResponse(
          success: false,
          message: result.exception.toString(),
        );
      }

      final res = result.data?['createLobby'];
      print("Create lobby response: $res");

      final createdLobby = Lobby.fromJson(res as Map<String, dynamic>);
      return GeneralResponse(success: true, data: createdLobby);
    } catch (e) {
      throw DataException.handleError(e);
    }
  }

  @override
  Future<GeneralResponse<dynamic>> joinLobby(String lobbyCode) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(joinLobbyMutation),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          "joinLobbyInput": {"lobbyCode": lobbyCode},
        },
      );
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        return GeneralResponse(
          success: false,
          message: result.exception.toString(),
        );
      }
      final res = result.data?['joinLobby'];

      final createdLobby = Lobby.fromJson(res as Map<String, dynamic>);
      return GeneralResponse(success: true, data: createdLobby);
    } catch (e) {
      throw DataException.handleError(e);
    }
  }

  @override
  Future<GeneralResponse> startLobby(String lobbyCode) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(startLobbyMutation),
        fetchPolicy: FetchPolicy.noCache,
        variables: {"lobbyCode": lobbyCode},
      );
      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        return GeneralResponse(
          success: false,
          message: result.exception.toString(),
        );
      }
      final res = result.data?['startLobby'];

      return GeneralResponse(success: true, data: res);
    } catch (e) {
      throw DataException.handleError(e);
    }
  }

  @override
  Stream<Map<String, dynamic>> watchLobbyLeaderboard(String lobbyCode) {
    try {
      final options = SubscriptionOptions(
        document: gql(watchLobbySubscription),
        variables: {'lobbyCode': lobbyCode},
        fetchPolicy: FetchPolicy.noCache,
      );
      return client.subscribe(options).map((result) {
        if (result.hasException) {
          throw Exception(
            result.exception.toString().replaceFirst('Exception: ', ''),
          );
        }

        final payload = result.data?['leaderboardUpdated'];
        if (payload is! Map<String, dynamic>) {
          throw Exception('Lobby subscription returned an invalid payload.');
        }

        return payload;
      });
    } catch (e) {
      throw DataException.handleError(e);
    }
  }

  @override
  Future<GeneralResponse> submitAnswer(
    bool isCorrect,
    String lobbyCode,
    int scoreDelta,
  ) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql(submitAnswerMutation),
        fetchPolicy: FetchPolicy.noCache,
        variables: {
          "submitAnswerInput": {
            "isCorrect": isCorrect,
            "lobbyCode": lobbyCode,
            "scoreDelta": scoreDelta,
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
      final res = result.data?['submitAnswer'];

      return GeneralResponse(success: true, data: res);
    } catch (e) {
      throw DataException.handleError(e);
    }
  }
}
