import 'package:book_app/core/shared_notifier/base_change_notifier.dart';
import 'package:book_app/locator.dart';
import 'package:book_app/modules/auth/provider/auth_notifier.dart';
import 'package:book_app/modules/books/provider/book_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider<AuthNotifier>(create: (_) => locator()),
  ChangeNotifierProvider<BookNotifier>(create: (_) => locator()),
  ChangeNotifierProvider<BaseChangeNotifier>(create: (_) => locator()),
  // ChangeNotifierProvider<AuthenticationProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<HomeProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<ListingProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<ProfileProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<PaymentProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<ListingProvider>(create: (_) => locator()),
  // ChangeNotifierProvider<MessageProvider>(create: (_) => locator()),
];
