import 'package:json_annotation/json_annotation.dart';
part 'token_response_model.g.dart';


@JsonSerializable()
class TokenResponseModel {
  TokenResponseModel({required this.accessToken, required this.refreshToken});

  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$TokenResponseModelToJson(this);
}
