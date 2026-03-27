import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:quizlet_app_flutter/core/shared_services/services/local_cache.dart';
import 'package:quizlet_app_flutter/locator.dart';

class GraphQLConfig {
  final cache = locator<LocalCache>();

  static final HttpLink httpLink = HttpLink(
    'https://book-app-8yf0.onrender.com/graphql',
  );
  static final WebSocketLink websocketLink = WebSocketLink(
    'wss://book-app-8yf0.onrender.com/graphql',
    subProtocol: GraphQLProtocol.graphqlTransportWs,
    config: SocketClientConfig(
      autoReconnect: true,
      onConnectionLost: (code, reason) async {
        print('WebSocket lost. code=$code reason=$reason');
        return const Duration(seconds: 2);
      },
      initialPayload: () async {
        final token = await locator<LocalCache>().getToken();
        if (token.isEmpty) {
          return {};
        }
        final bearerToken = 'Bearer $token';
        return {
          'Authorization': bearerToken,
          'authorization': bearerToken,
          'headers': {'Authorization': bearerToken},
        };
      },
    ),
  );

  AuthLink get authLink => AuthLink(
    getToken: () async {
      final token = await cache.getToken();
      print("Auth Token: $token");
      if (token.isEmpty) return null;
      return 'Bearer $token';
    },
  );

  GraphQLClient clientToQuery() {
    final Link authHttpLink = authLink.concat(httpLink);
    final Link link = Link.split(
      (request) => request.isSubscription,
      websocketLink,
      authHttpLink,
    );
    return GraphQLClient(link: link, cache: GraphQLCache());
  }
}
