import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:quizlet_app_flutter/core/shared_notifier/base_change_notifier.dart';
import 'package:quizlet_app_flutter/locator.dart';
import 'package:quizlet_app_flutter/modules/provider/auth_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/flashcard_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/lobby_provider.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<AuthProvider>(create: (_) => locator()),
  ChangeNotifierProvider<LobbyNotifier>(create: (_) => locator()),
  ChangeNotifierProvider<BaseChangeNotifier>(create: (_) => locator()),
  ChangeNotifierProvider<FlashcardProvider>(create: (_) => locator()),

  // ChangeNotifierProvider<AuthenticationProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<HomeProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<ListingProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<ProfileProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<PaymentProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<ListingProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<MessageProvider>(create: (_) => locator()),
];
