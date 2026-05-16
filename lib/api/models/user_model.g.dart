// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  avatarUrl: json['avatar_url'] as String?,
  bio: json['bio'] as String?,
  postCount: (json['post_count'] as num).toInt(),
  commentCount: (json['comment_count'] as num).toInt(),
  likeCount: (json['like_count'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'avatar_url': instance.avatarUrl,
  'bio': instance.bio,
  'post_count': instance.postCount,
  'comment_count': instance.commentCount,
  'like_count': instance.likeCount,
  'created_at': instance.createdAt.toIso8601String(),
};
