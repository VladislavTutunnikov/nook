part of 'search_bloc.dart';

abstract class SearchEvent {}

class SearchNooks extends SearchEvent {
  SearchNooks({
    this.isRefresh = false,
    this.prompt = '',
    this.limit = 20,
    this.offset = 0,
  });
  final bool isRefresh;
  final String prompt;
  final int limit;
  final int offset;
}
