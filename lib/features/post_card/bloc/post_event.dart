part of 'post_bloc.dart';

abstract class PostEvent {}

class SetupData extends PostEvent {}

class LikePost extends PostEvent {}

class RepostPost extends PostEvent {}

class SavePost extends PostEvent {}

class PinPost extends PostEvent {}

class DeletePost extends PostEvent {}