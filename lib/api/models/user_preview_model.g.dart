// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreviewModel _$UserPreviewModelFromJson(Map<String, dynamic> json) =>
    UserPreviewModel(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$UserPreviewModelToJson(UserPreviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar_url': instance.avatarUrl,
    };
