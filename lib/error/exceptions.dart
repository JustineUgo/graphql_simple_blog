import 'package:dio/dio.dart';

abstract class TrackedException implements Exception {
  final String name;
  final DioExceptionType? cause;
  final int? statusCode;
  final dynamic exception;
  final dynamic stacktrace;

  TrackedException({required this.name, this.cause, this.statusCode, this.exception, this.stacktrace});
}

class UnknownException extends TrackedException {
  UnknownException({required super.exception, required super.stacktrace}) : super(name: 'UnknownError');
}

class ConnectionException extends TrackedException {
  ConnectionException({required super.cause, required super.statusCode}) : super(name: 'HttpException');
}
