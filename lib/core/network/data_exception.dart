import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DataException implements Exception {
  DataException({required this.message});

  DataException.handleError(Object error) {
    if (error is DioException) {
      _handleDioError(error);
    } else {
      _handleException(error);
    }
  }

  String message = '';

  void _handleDioError(DioException dioException) {
    debugPrint('DioException: $dioException');
    switch (dioException.type) {
      case DioExceptionType.cancel:
        message = 'Request to server was cancelled';
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout with server';
      case DioExceptionType.receiveTimeout:
        message = 'Receive timeout in connection with server';
      case DioExceptionType.badResponse:
        message = _handleResponseError(dioException.response!);
      case DioExceptionType.sendTimeout:
        message = 'Send timeout in connection wth server';
      case DioExceptionType.connectionError:
        message = 'An error occurred connecting to the server';
      case DioExceptionType.badCertificate:
        message = 'Expired certificate';
      case DioExceptionType.unknown:
        message = 'Connection to server failed due no internet connection';
    }
  }

  void _handleException(dynamic exception) {
    debugPrint('Exception: $exception');
    if (exception is SocketException) {
      message = 'No internet connection';
    } else if (exception is String) {
      message = exception;
    } else if (exception is Exception) {
      message = exception.toString();
    } else {
      message = 'An unexpected error occurred, please try again';
    }
  }

  String _handleResponseError(Response<dynamic> response) {
    log('Error: ${response.data}');
    if (response.data != null) {
      try {
        final errorResponse = response.data as Map<String, dynamic>?;
        return (errorResponse?['message'] as String?) ?? '';
      } catch (_) {
        return response.data.toString();
      }
    } else {
      switch (response.statusCode) {
        case 400:
          return 'Bad request';
        case 404:
          return 'The requested resource was not found';
        case 500:
          return 'Internal server error';
        default:
          return 'Something went wrong';
      }
    }
  }

  @override
  String toString() => message;
}
