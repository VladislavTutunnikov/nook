import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/repositories/user_repository.dart';

part 'user_nooks_event.dart';
part 'user_nooks_state.dart';

class UserNooksBloc extends Bloc<UserNooksEvent, UserNooksState> {
  UserNooksBloc({required this.userRepository}) : super(UserNooksInitial()) {
    on<LoadUserNooks>((event, emit) async {
      if (event.isRefresh) {
        emit(UserNooksLoading());

        _cachedNooks.clear();
        _nooksOffset = 0;
        _hasMoreNooks = true;
        _isLoading = false;
      }

      if (_isLoading) return;

      if (event.offset > 0 && !_hasMoreNooks) return;

      _isLoading = true;

      try {
        final List<NookModel> nooks = await userRepository.getMyNooks(
          limit: event.limit,
          offset: event.offset,
        );

        _cachedNooks.addAll(nooks);
        _hasMoreNooks = nooks.length >= event.limit;
        _nooksOffset = event.offset + nooks.length;

        emit(
          UserNooksLoaded(
            nooks: _cachedNooks,
            hasMore: _hasMoreNooks,
            offset: _nooksOffset,
          ),
        );
      } catch (e) {
        if (_cachedNooks.isEmpty) {
          emit(UserNooksLoadingFailure(error: e.toString()));
        }
      } finally {
        _isLoading = false;
      }
    });
  }

  final UserRepository userRepository;

  bool _isLoading = false;

  final List<NookModel> _cachedNooks = [];
  int _nooksOffset = 0;
  bool _hasMoreNooks = true;
}
