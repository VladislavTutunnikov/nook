import 'package:json_annotation/json_annotation.dart';
part 'nook_model.g.dart';

@JsonSerializable()
class NookModel {
  NookModel({
    required this.id,
    required this.name,
    required this.description,
    required this.avatarUrl,
    required this.rules,
    required this.isOver18,
    required this.followersCount,
    required this.postCount,
    required this.categoryId,
    required this.categoryName,
    required this.ownerId,
    required this.createdAt,
    required this.isFollowed,
  });

  final String id;
  final String name;

  final String? description;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  final String? rules;

  @JsonKey(name: 'is_over_18')
  final bool isOver18;

  @JsonKey(name: 'followers_count')
  final int followersCount;

  @JsonKey(name: 'post_count')
  final int postCount;

  @JsonKey(name: 'category_id')
  final String? categoryId;

  @JsonKey(name: 'category_name')
  final String? categoryName;

  @JsonKey(name: 'owner_id')
  final String? ownerId;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @JsonKey(name: 'is_followed')
  final bool isFollowed;

  factory NookModel.fromJson(Map<String, dynamic> json) =>
      _$NookModelFromJson(json);
  Map<String, dynamic> toJson() => _$NookModelToJson(this);
}
