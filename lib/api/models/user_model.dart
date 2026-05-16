import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  const UserModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.bio,
    required this.postCount,
    required this.commentCount,
    required this.likeCount,
    required this.createdAt,
  });

  final String id;
  final String username;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  final String? bio;

  @JsonKey(name: 'post_count')
  final int postCount;

  @JsonKey(name: 'comment_count')
  final int commentCount;

  @JsonKey(name: 'like_count')
  final int likeCount;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
