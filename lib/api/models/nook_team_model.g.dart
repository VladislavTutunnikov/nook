// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nook_team_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NookTeamModel _$NookTeamModelFromJson(Map<String, dynamic> json) =>
    NookTeamModel(
      owner: json['owner'] == null
          ? null
          : UserPreviewModel.fromJson(json['owner'] as Map<String, dynamic>),
      moderators: (json['moderators'] as List<dynamic>?)
          ?.map((e) => NookMemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NookTeamModelToJson(NookTeamModel instance) =>
    <String, dynamic>{
      'owner': instance.owner,
      'moderators': instance.moderators,
    };
