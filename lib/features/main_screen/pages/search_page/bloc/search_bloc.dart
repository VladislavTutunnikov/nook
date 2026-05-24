import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({required this.nookRepository}) : super(SearchInitial()) {
    on<SearchNooks>((event, emit) async {
      if (event.prompt.trim().isEmpty) {
        emit(SearchEmpty());
        return;
      }

      if (event.isRefresh) {
        emit(SearchLoading());

        _cachedNooks.clear();
        _nooksOffset = 0;
        _hasMoreNooks = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (event.offset > 0 && !_hasMoreNooks) return;

      _isLoading = true;

      try {
        final List<NookModel> nooks = await nookRepository.searchNooks(
          prompt: event.prompt,
          limit: event.limit,
          offset: event.offset,
        );

        _cachedNooks.addAll(nooks);
        _hasMoreNooks = nooks.length >= event.limit;
        _nooksOffset = event.offset + nooks.length;

        emit(
          SearchLoaded(
            nooks: _cachedNooks,
            hasMore: _hasMoreNooks,
            offset: _nooksOffset,
          ),
        );
      } catch (e) {
        if (_cachedNooks.isEmpty) {
          emit(SearchLoadingFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });
  }
  final NookRepository nookRepository;

  bool _isLoading = false;

  final List<NookModel> _cachedNooks = [];
  int _nooksOffset = 0;
  bool _hasMoreNooks = true;
}
