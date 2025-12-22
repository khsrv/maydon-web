
// path: lib/src/core/error/app_failure.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_failure.freezed.dart';
part 'app_failure.g.dart';

@freezed
abstract class AppFailure with _$AppFailure {
  const factory AppFailure.network({String? message, int? statusCode}) = _Network;
  const factory AppFailure.unauthorized({String? message}) = _Unauthorized;
  const factory AppFailure.server({String? message, int? statusCode}) = _Server;
  const factory AppFailure.timeout({String? message}) = _Timeout;
  const factory AppFailure.serialization({String? message}) = _Serialization;
  const factory AppFailure.cache({String? message}) = _Cache;
  const factory AppFailure.offline({String? message}) = _Offline;
  const factory AppFailure.unknown({String? message}) = _Unknown;

  factory AppFailure.fromJson(Map<String, dynamic> json) =>
      _$AppFailureFromJson(json);
}

extension AppFailureX on AppFailure {
  String toFriendlyMessage() => when(
        network: (msg, code) =>
            msg ?? 'Network error${code != null ? ' ($code)' : ''}',
        unauthorized: (msg) => msg ?? 'Unauthorized',
        server: (msg, code) =>
            msg ?? 'Server error${code != null ? ' ($code)' : ''}',
        timeout: (msg) => msg ?? 'Request timeout',
        serialization: (msg) => msg ?? 'Data parsing error',
        cache: (msg) => msg ?? 'Cache error',
        offline: (msg) => msg ?? 'You are offline',
        unknown: (msg) => msg ?? 'Unknown error',
      );
}
