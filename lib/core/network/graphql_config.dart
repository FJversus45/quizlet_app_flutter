// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:quizlet_app_flutter/core/shared_services/services/local_cache.dart';

// class GraphqlConfig {
//   final cache = locator<LocalCache>();

//   static HttpLink httpLink = HttpLink(
//     'https://todo-app-graphql-beta.onrender.com/graphql',
//   );

//   AuthLink get authLink => AuthLink(
//     getToken: () async {
//       final token = await cache.getToken();
//       if (token.isEmpty) return null;
//       return "Bearer $token";
//     },
//   );

//   GraphQLClient clientToQuery() {
//     final Link link = authLink.concat(httpLink);
//     return GraphQLClient(link: link, cache: GraphQLCache());
//   }
// }
