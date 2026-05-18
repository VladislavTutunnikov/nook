import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nook/api/models/nook_preview_model.dart';
import 'package:nook/api/models/user_preview_model.dart';
part 'post_model.g.dart';

@JsonSerializable()
class PostModel extends Equatable {
  const PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.photos,
    required this.isEdited,
    required this.isPinned,
    required this.likeCount,
    required this.commentCount,
    required this.repostCount,
    required this.createdAt,
    required this.nook,
    required this.user,
    required this.isLiked,
    required this.isReposted,
    required this.isSaved,
  });

  final String id;
  final String title;
  final String? content;
  final List<String> photos;

  @JsonKey(name: 'is_edited')
  final bool isEdited;

  @JsonKey(name: 'is_pinned')
  final bool isPinned;

  @JsonKey(name: 'like_count')
  final int likeCount;

  @JsonKey(name: 'comment_count')
  final int commentCount;

  @JsonKey(name: 'repost_count')
  final int repostCount;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  final NookPreviewModel nook;
  final UserPreviewModel user;

  @JsonKey(name: 'is_liked')
  final bool isLiked;

  @JsonKey(name: 'is_reposted')
  final bool isReposted;

  @JsonKey(name: 'is_saved')
  final bool isSaved;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    photos,
    isEdited,
    likeCount,
    commentCount,
    repostCount,
    createdAt,
    nook,
    user,
    isLiked,
    isReposted,
    isSaved,
  ];
}
