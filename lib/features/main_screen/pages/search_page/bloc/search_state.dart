part of 'search_bloc.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchEmpty extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  SearchLoaded({
    required this.nooks,
    required this.hasMore,
    required this.offset,
  });

  final List<NookModel> nooks;
  final bool hasMore;
  final int offset;
}

class SearchLoadingFailure extends SearchState {
  SearchLoadingFailure({required this.error});

  final String error;
}
