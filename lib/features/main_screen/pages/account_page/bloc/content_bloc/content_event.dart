part of 'content_bloc.dart';

abstract class ContentEvent {}

class LoadPosts extends ContentEvent {
  LoadPosts({this.isRefresh = false, this.limit = 20, this.offset = 0});
  final bool isRefresh;
  final int limit;
  final int offset;
}

class LoadComments extends ContentEvent {
  LoadComments({this.isRefresh = false, this.limit = 20, this.offset = 0});
  final bool isRefresh;
  final int limit;
  final int offset;
}

class LoadReposts extends ContentEvent {
  LoadReposts({this.isRefresh = false, this.limit = 20, this.offset = 0});
  final bool isRefresh;
  final int limit;
  final int offset;
}

class LoadLikes extends ContentEvent {
  LoadLikes({this.isRefresh = false, this.limit = 20, this.offset = 0});
  final bool isRefresh;
  final int limit;
  final int offset;
}
