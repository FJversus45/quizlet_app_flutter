import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:quizlet_app_flutter/core/shared_services/implementations/local_cache_impl.dart';
import 'package:quizlet_app_flutter/core/shared_services/implementations/secure_storage_impl.dart';
import 'package:quizlet_app_flutter/core/shared_services/services/local_cache.dart';
import 'package:quizlet_app_flutter/core/shared_services/services/secure_storage.dart';
import 'package:quizlet_app_flutter/modules/provider/auth_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/flashcard_provider.dart';
import 'package:quizlet_app_flutter/modules/provider/lobby_provider.dart';
import 'package:quizlet_app_flutter/modules/services/auth_service.dart';
import 'package:quizlet_app_flutter/modules/services/auth_service_impl.dart';
import 'package:quizlet_app_flutter/modules/services/flashcard_set_service_impl.dart';
import 'package:quizlet_app_flutter/modules/services/flashcard_sets_service.dart';
import 'package:quizlet_app_flutter/modules/services/lobby_service.dart';
import 'package:quizlet_app_flutter/modules/services/lobby_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final locator = GetIt.instance;

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> setupLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  // final dio = Dio(BaseOptions(
  //   baseUrl: Endpoints.baseUrl,
  //   connectTimeout: const Duration(minutes: 5),
  //   receiveTimeout: const Duration(minutes: 3),
  // ));

  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  // locator.registerSingleton<Dio>(dio);
  locator.registerLazySingleton<SecureStorage>(() => SecureStorageImpl());

  locator.registerLazySingleton<LocalCache>(
    () => LocalCacheImpl(prefs: locator(), storage: locator()),
  );
  // Register NetworkClient using dio and shared preferences
  // final networkClient = NetworkClient(cache: locator(), dio: dio);
  // locator.registerSingleton<NetworkClient>(networkClient);
  locator.registerLazySingleton<AuthService>(() => AuthServiceImpl());
  locator.registerLazySingleton<LobbyService>(() => LobbyServiceImpl());

  locator.registerLazySingleton<FlashCardSetsService>(
    () => FlashcardSetServiceImpl(),
  );
  // locator.registerLazySingleton<ListingService>(() => ListingServiceImpl(
  //       networkClient: networkClient,
  //     ));
  // locator.registerLazySingleton<PaystackService>(() => PaystackServiceImpl(
  //       networkClient: networkClient,
  //     ));
  // locator.registerLazySingleton<ProfileServices>(() => ProfileServicesImpl(
  //       networkClient: networkClient,
  //     ));
  // locator.registerLazySingleton<GeminiService>(() => GeminiServiceImpl(
  //       networkClient: networkClient,
  //     ));

  // locator.registerLazySingleton<AuthProvider>(
  //   () => AuthenticationProvider(),
  // );

  // locator.registerLazySingleton<ListingProvider>(() => ListingProvider());
  // locator.registerLazySingleton<ProfileProvider>(() => ProfileProvider());
  // locator.registerLazySingleton<HomeProvider>(() => HomeProvider());
  // locator.registerLazySingleton<PaymentProvider>(() => PaymentProvider());
  // locator.registerLazySingleton<MessageProvider>(() => MessageProvider());
  // locator
  //     .registerLazySingleton<AiGeneratorNotifier>(() => AiGeneratorNotifier());
  // locator.registerLazySingleton<ScreenLoaderProvider>(
  //     () => ScreenLoaderProvider());

  // locator
  //     .registerLazySingleton<NotificationService>(() => NotificationService());

  locator.registerLazySingleton<AuthProvider>(() => AuthProvider());
  locator.registerLazySingleton<LobbyNotifier>(() => LobbyNotifier());
  locator.registerLazySingleton<FlashcardProvider>(() => FlashcardProvider());
  // locator.registerLazySingleton<BookNotifier>(() => BookNotifier());
}
