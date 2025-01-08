// ignore_for_file: non_constant_identifier_names

import 'package:json_annotation/json_annotation.dart';

part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class BaseResponse<T> {
  @JsonKey(name: 'error_code')
  int? error_code;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'data')
  T? data;

  BaseResponse({
    this.error_code,
    this.message,
    this.data,
  });

  factory BaseResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T? value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}
