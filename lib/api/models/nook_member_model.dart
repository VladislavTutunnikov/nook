import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'nook_member_model.g.dart';

enum MemberRole {
  @JsonValue('MEMBER')
  member,
  @JsonValue('MODERATOR')
  moderator,
}

@JsonSerializable()
class NookMemberModel extends Equatable {
  const NookMemberModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.role,
    required this.isBanned,
    required this.canBan,
    required this.canMakeModerator,
  });

  final String id;
  final String username;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  final MemberRole role;

  @JsonKey(name: 'is_banned')
  final bool isBanned;

  @JsonKey(name: 'can_ban')
  final bool canBan;

  @JsonKey(name: 'can_make_moderator')
  final bool canMakeModerator;

  factory NookMemberModel.fromJson(Map<String, dynamic> json) =>
      _$NookMemberModelFromJson(json);
  Map<String, dynamic> toJson() => _$NookMemberModelToJson(this);

  @override
  List<Object?> get props => [id, username, avatarUrl, role];
}
