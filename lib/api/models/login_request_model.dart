import 'package:json_annotation/json_annotation.dart';
part 'login_request_model.g.dart';


@JsonSerializable()
class LoginRequestModel {
  LoginRequestModel({required this.login, required this.password});

  final String login;
  final String password;

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
