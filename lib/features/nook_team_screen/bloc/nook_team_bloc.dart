import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/api/models/nook_team_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';
part 'nook_team_event.dart';
part 'nook_team_state.dart';

class NookTeamBloc extends Bloc<NookTeamEvent, NookTeamState> {
  NookTeamBloc({required this.nookRepository, required this.nookId})
    : super(NookTeamInitial()) {
    on<LoadNookTeam>((event, emit) async {
      emit(NookTeamLoading());

      try {
        final NookTeamModel team = await nookRepository.getNookTeam(
          nookId: nookId,
        );

        final NookMemberModel? owner = team.owner == null
            ? null
            : NookMemberModel(
                id: team.owner!.id,
                username: team.owner!.username,
                avatarUrl: team.owner!.avatarUrl,
                role: MemberRole.moderator,
                isBanned: false,
                canBan: false,
                canMakeModerator: false,
              );
        final List<NookMemberModel>? moderators = team.moderators;

        emit(NookTeamLoaded(owner: owner, moderators: moderators));
      } catch (e) {
        emit(NookTeamLoadingFailure(error: e.toString()));
      }
    });
  }

  final NookRepository nookRepository;
  final String nookId;
}
