// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nook_preview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NookPreviewModel _$NookPreviewModelFromJson(Map<String, dynamic> json) =>
    NookPreviewModel(
      id: json['id'] as String,
      name: json['name'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$NookPreviewModelToJson(NookPreviewModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
    };
