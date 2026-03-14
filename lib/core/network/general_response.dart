import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:quizlet_app_flutter/core/network/failure.dart';

abstract class ApiResponse {}

class Success extends ApiResponse with EquatableMixin {
  final Map<String, dynamic> data;

  Success(this.data);

  @override
  List<Object?> get props => [data];
}

class GeneralResponse<T> extends Equatable {
  final bool success;
  final String message;
  final T? data;

  const GeneralResponse({this.success = false, this.message = '', this.data});

  factory GeneralResponse.fromJson(
    Either<ApiFailure, Success> json, {
    T Function(Map<String, dynamic> json)? parseJson,
    String Function(Map<String, dynamic> json)? parseMessage,
  }) {
    return json.fold((failure) => GeneralResponse(message: failure.message), (
      success,
    ) {
      final status = success.data['status'] == null
          ? ""
          : success.data['status'] as String;
      return GeneralResponse(
        success: status == 'success',
        message: status,
        data: parseJson != null
            ? parseJson(success.data)
            : success.data['data'],
      );
    });
  }

  @override
  List<Object?> get props => [success, message];
}
