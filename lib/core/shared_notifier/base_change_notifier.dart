import 'package:flutter/material.dart';

class BaseChangeNotifier extends ChangeNotifier {
  late AuthService authService;
  late BookServices bookServices;

  BaseChangeNotifier({AuthService? authService, BookServices? bookServices}) {
    this.authService = authService ?? locator();
    this.bookServices = bookServices ?? locator();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  String _message = '';
  String get message => _message;

  set setMessage(String message) {
    _message = message;
    notifyListeners();
  }

  void handleError(String? message) {
    setLoading = false;
    setMessage = message ?? 'Failed';
    notifyListeners();
  }

  void handleSuccess(String? message) {
    setLoading = false;
    setMessage = message ?? 'Successful';
    notifyListeners();
  }

  // Future<String> get appVersionNumber async {
  //   Map<String, dynamic> appVersionDetails = await getVersionNumber();
  //   return appVersionDetails['version'] ?? '';
  // }

  // Future<String> get appVersion async {
  //   // String baseURL = await this.userRepository.getBaseURl();

  //   Map<String, dynamic> appVersionDetails = await getVersionNumber();

  //   String versionNumber = '';

  //   String releaseVersion = 'RELEASE';

  //   if (releaseVersion.toUpperCase() == 'STAGING') {
  //     versionNumber = 'V' + appVersionDetails['version'];
  //     //  +
  //     // " T." +
  //     // appVersionDetails["buildNumber"];
  //   } else {
  //     versionNumber = 'V' + appVersionDetails['version'];
  //     //  +
  //     // " b." +
  //     // appVersionDetails["buildNumber"];
  //   }

  //   return versionNumber;
  // }

  // Future<Map<String, dynamic>> getVersionNumber() async {
  //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //   String appName = packageInfo.appName;
  //   String packageName = packageInfo.packageName;
  //   String version = packageInfo.version;
  //   String buildNumber = packageInfo.buildNumber;

  //   return {
  //     'appName': appName,
  //     'packageName': packageName,
  //     'version': version,
  //     'buildNumber': buildNumber,
  //   };
  // }

  // Future<bool> checkInternet() async =>
  //     await InternetConnection().hasInternetAccess;
}
