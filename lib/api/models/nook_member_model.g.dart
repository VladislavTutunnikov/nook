// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nook_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NookMemberModel _$NookMemberModelFromJson(Map<String, dynamic> json) =>
    NookMemberModel(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String?,
      role: $enumDecode(_$MemberRoleEnumMap, json['role']),
      isBanned: json['is_banned'] as bool,
      canBan: json['can_ban'] as bool,
      canMakeModerator: json['can_make_moderator'] as bool,
    );

Map<String, dynamic> _$NookMemberModelToJson(NookMemberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar_url': instance.avatarUrl,
      'role': _$MemberRoleEnumMap[instance.role]!,
      'is_banned': instance.isBanned,
      'can_ban': instance.canBan,
      'can_make_moderator': instance.canMakeModerator,
    };

const _$MemberRoleEnumMap = {
  MemberRole.member: 'MEMBER',
  MemberRole.moderator: 'MODERATOR',
};
