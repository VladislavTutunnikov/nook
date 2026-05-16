import 'package:json_annotation/json_annotation.dart';
part 'refresh_request_model.g.dart';


@JsonSerializable()
class RefreshRequestModel {
  RefreshRequestModel({required this.refreshToken});

  @JsonKey(name: 'refresh_token')
  final String refreshToken;

  factory RefreshRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RefreshRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshRequestModelToJson(this);
}