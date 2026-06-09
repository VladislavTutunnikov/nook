// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentModel _$CommentModelFromJson(Map<String, dynamic> json) => CommentModel(
  id: json['id'] as String,
  postId: json['post_id'] as String,
  content: json['content'] as String,
  photos: (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
  isEdited: json['is_edited'] as bool,
  likeCount: (json['like_count'] as num).toInt(),
  commentCount: (json['comment_count'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  user: UserPreviewModel.fromJson(json['user'] as Map<String, dynamic>),
  isLiked: json['is_liked'] as bool,
  isSaved: json['is_saved'] as bool,
  path: (json['path'] as List<dynamic>).map((e) => e as String).toList(),
  depth: (json['depth'] as num).toInt(),
);

Map<String, dynamic> _$CommentModelToJson(CommentModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'post_id': instance.postId,
      'content': instance.content,
      'photos': instance.photos,
      'is_edited': instance.isEdited,
      'like_count': instance.likeCount,
      'comment_count': instance.commentCount,
      'path': instance.path,
      'created_at': instance.createdAt.toIso8601String(),
      'user': instance.user,
      'is_liked': instance.isLiked,
      'is_saved': instance.isSaved,
      'depth': instance.depth,
    };
