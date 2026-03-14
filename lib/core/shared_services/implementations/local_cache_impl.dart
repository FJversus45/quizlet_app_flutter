import 'dart:convert';
import 'package:quizlet_app_flutter/core/prefs_keys/prefs_keys.dart';
import 'package:quizlet_app_flutter/core/shared_services/services/local_cache.dart';
import 'package:quizlet_app_flutter/core/shared_services/services/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCacheImpl implements LocalCache {
  late SecureStorage storage;
  late SharedPreferences prefs;

  LocalCacheImpl({required this.storage, required this.prefs});

  @override
  Future<void> deleteToken() async {
    try {
      await storage.delete(PrefsKeys.token.key);
    } catch (e) {}
  }

  @override
  Object? getFromLocalCache(String key) {
    try {
      return prefs.get(key);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String> getToken() async {
    try {
      return (await storage.read(PrefsKeys.token.key))!;
    } catch (e) {
      return "";
    }
  }

  @override
  Future<void> removeFromLocalCache(String key) async {
    await prefs.remove(key);
  }

  @override
  Future<void> saveToLocalCache({required String key, required value}) async {
    if (value is String) {
      await prefs.setString(key, value);
    }
    if (value is bool) {
      await prefs.setBool(key, value);
    }
    if (value is int) {
      await prefs.setInt(key, value);
    }
    if (value is double) {
      await prefs.setDouble(key, value);
    }
    if (value is List<String>) {
      await prefs.setStringList(key, value);
    }
    if (value is Map) {
      await prefs.setString(key, json.encode(value));
    }
  }

  @override
  Future<void> saveToken(String tokenId) async {
    try {
      await storage.write(key: PrefsKeys.token.key, value: tokenId);
    } catch (e) {}
  }

  @override
  Future<void> saveListingDraft(Map<String, dynamic> draft) async {
    final jsonString = json.encode(draft);
    await prefs.setString(PrefsKeys.listingDraft.key, jsonString);
  }

  @override
  Map<String, dynamic>? getListingDraft() {
    final jsonString = prefs.getString(PrefsKeys.listingDraft.key);
    if (jsonString == null) return null;
    try {
      return json.decode(jsonString);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearListingDraft() async {
    await prefs.remove(PrefsKeys.listingDraft.key);
  }
}
