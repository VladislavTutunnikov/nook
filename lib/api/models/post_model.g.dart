// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String?,
  photos: (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
  isEdited: json['is_edited'] as bool,
  isPinned: json['is_pinned'] as bool,
  likeCount: (json['like_count'] as num).toInt(),
  commentCount: (json['comment_count'] as num).toInt(),
  repostCount: (json['repost_count'] as num).toInt(),
  createdAt: DateTime.parse(json['created_at'] as String),
  nook: NookPreviewModel.fromJson(json['nook'] as Map<String, dynamic>),
  user: UserPreviewModel.fromJson(json['user'] as Map<String, dynamic>),
  isLiked: json['is_liked'] as bool,
  isReposted: json['is_reposted'] as bool,
  isSaved: json['is_saved'] as bool,
  canDelete: json['can_delete'] as bool,
  canEdit: json['can_edit'] as bool,
  canPin: json['can_pin'] as bool,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'photos': instance.photos,
  'is_edited': instance.isEdited,
  'is_pinned': instance.isPinned,
  'like_count': instance.likeCount,
  'comment_count': instance.commentCount,
  'repost_count': instance.repostCount,
  'created_at': instance.createdAt.toIso8601String(),
  'nook': instance.nook,
  'user': instance.user,
  'is_liked': instance.isLiked,
  'is_reposted': instance.isReposted,
  'is_saved': instance.isSaved,
  'can_delete': instance.canDelete,
  'can_edit': instance.canEdit,
  'can_pin': instance.canPin,
};
