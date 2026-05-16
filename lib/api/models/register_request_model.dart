import 'package:json_annotation/json_annotation.dart';
part 'register_request_model.g.dart';


@JsonSerializable()
class RegisterRequestModel {
  RegisterRequestModel({required this.email, required this.username, required this.password});

  final String email;
  final String username;
  final String password;

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}