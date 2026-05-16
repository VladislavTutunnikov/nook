import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'nook_preview_model.g.dart';

@JsonSerializable()
class NookPreviewModel extends Equatable {
  const NookPreviewModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  final String id;
  final String name;

  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  factory NookPreviewModel.fromJson(Map<String, dynamic> json) =>
      _$NookPreviewModelFromJson(json);
  Map<String, dynamic> toJson() => _$NookPreviewModelToJson(this);

  @override
  List<Object?> get props => [id, name, avatarUrl];
}
