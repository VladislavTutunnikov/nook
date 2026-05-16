import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_preview_model.g.dart';

@JsonSerializable()
class UserPreviewModel extends Equatable {
  const UserPreviewModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
  });

  final String id;
  final String username;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  factory UserPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$UserPreviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserPreviewModelToJson(this);

  @override
  List<Object?> get props => [id, username, avatarUrl];
}
