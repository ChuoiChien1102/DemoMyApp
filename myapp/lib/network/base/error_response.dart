import 'package:json_annotation/json_annotation.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {
  final String? timestamp;
  final int? code;
  final String? error;
  final String? msg;
  final String? path;

  ErrorResponse({
    this.timestamp,
    this.code,
    this.path,
    this.msg,
    this.error,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorResponseToJson(this);
}
