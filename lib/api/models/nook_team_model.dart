import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/api/models/user_preview_model.dart';
part 'nook_team_model.g.dart';

@JsonSerializable()
class NookTeamModel extends Equatable {
  const NookTeamModel({
    required this.owner,
    required this.moderators,
  });

  final UserPreviewModel? owner;
  final List<NookMemberModel>? moderators;

  factory NookTeamModel.fromJson(Map<String, dynamic> json) =>
      _$NookTeamModelFromJson(json);
  Map<String, dynamic> toJson() => _$NookTeamModelToJson(this);

  @override
  List<Object?> get props => [owner, moderators];
}
