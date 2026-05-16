import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nook/api/models/user_preview_model.dart';
part 'comment_model.g.dart';

@JsonSerializable()
class CommentModel extends Equatable {
  const CommentModel({
    required this.id,
    required this.postId,
    required this.content,
    required this.photos,
    required this.isEdited,
    required this.likeCount,
    required this.commentCount,
    required this.createdAt,
    required this.user,
    required this.isLiked,
    required this.isSaved,
  });

  final String id;

  @JsonKey(name: 'post_id')
  final String postId;

  final String content;

  final List<String> photos;

  @JsonKey(name: 'is_edited')
  final bool isEdited;

  @JsonKey(name: 'like_count')
  final int likeCount;

  @JsonKey(name: 'comment_count')
  final int commentCount;

  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  final UserPreviewModel user;

  @JsonKey(name: 'is_liked')
  final bool isLiked;

  @JsonKey(name: 'is_saved')
  final bool isSaved;

  factory CommentModel.fromJson(Map<String, dynamic> json) =>
      _$CommentModelFromJson(json);
  Map<String, dynamic> toJson() => _$CommentModelToJson(this);

  @override
  List<Object?> get props => [
    id,
    postId,
    content,
    photos,
    isEdited,
    likeCount,
    commentCount,
    createdAt,
    user,
    isLiked,
    isSaved,
  ];
}
