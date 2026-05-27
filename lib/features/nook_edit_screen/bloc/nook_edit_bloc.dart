import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:share_plus/share_plus.dart';

part 'nook_edit_event.dart';
part 'nook_edit_state.dart';

class NookEditBloc extends Bloc<NookEditEvent, NookEditState> {
  NookEditBloc({required this.nookRepository, required this.nook})
    : super(NookEditInitial()) {
    on<DeleteAvatar>((event, emit) async {
      if (nook == null) return;
      try {
        await nookRepository.deleteNookAvatar(nookId: nook!.id);
        emit(AvatarDeleteSuccess());
      } catch (e) {
        emit(AvatarDeleteFailure());
      }
    });

    on<UpdateNook>((event, emit) async {
      if (event.name.isEmpty) {
        emit(EmptyNameError());
        return;
      }

      if (event.categoryId == null) {
        emit(EmptyCategoryError());
        return;
      }

      if (nook != null) {
        if (nook!.name == event.name &&
            nook!.description == event.description &&
            nook!.rules == event.rules &&
            nook!.categoryId == event.categoryId &&
            event.avatarImg == null) {
          emit(NookUpdated());
          return;
        }
      }

      emit(NookUpdateLoading());
      try {
        if (nook == null) {
          await nookRepository.createNook(
            name: event.name,
            description: event.description,
            rules: event.rules,
            categoryId: event.categoryId!,
            avatarPath: event.avatarImg?.path,
          );
        } else {
          await nookRepository.updateNook(
            nookId: nook!.id,
            name: event.name,
            description: event.description,
            rules: event.rules,
            categoryId: event.categoryId!,
            avatarPath: event.avatarImg?.path,
          );
        }
        emit(NookUpdated());
      } on NameTakenException catch (_) {
        emit(NameAlreadyTakenError());
      } catch (e) {
        emit(NookUpdateLoadingFailure());
      }
    });
  }

  final NookRepository nookRepository;
  final NookModel? nook;
}
