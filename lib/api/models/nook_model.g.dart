// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nook_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NookModel _$NookModelFromJson(Map<String, dynamic> json) => NookModel(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  rules: json['rules'] as String?,
  isOver18: json['is_over_18'] as bool,
  followersCount: (json['followers_count'] as num).toInt(),
  postCount: (json['post_count'] as num).toInt(),
  categoryId: json['category_id'] as String?,
  ownerId: json['owner_id'] as String?,
  createdAt: DateTime.parse(json['created_at'] as String),
  isFollowed: json['is_followed'] as bool,
);

Map<String, dynamic> _$NookModelToJson(NookModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'avatar_url': instance.avatarUrl,
  'rules': instance.rules,
  'is_over_18': instance.isOver18,
  'followers_count': instance.followersCount,
  'post_count': instance.postCount,
  'category_id': instance.categoryId,
  'owner_id': instance.ownerId,
  'created_at': instance.createdAt.toIso8601String(),
  'is_followed': instance.isFollowed,
};
