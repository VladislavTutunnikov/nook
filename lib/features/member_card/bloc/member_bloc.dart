import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';

part 'member_event.dart';
part 'member_state.dart';

class MemberBloc extends Bloc<MemberEvent, MemberState> {
  MemberBloc({
    required this.nookRepository,
    required this.member,
    required this.nookId,
  }) : super(MemberInitial()) {
    on<SetupData>((event, emit) {
      _isBanned = member.isBanned;
      _memberRole = member.role;

      emit(MemberUpdated(isBanned: _isBanned, memberRole: _memberRole));
    });

    on<BanMember>((event, emit) async {
      if (_isProcessingBan) return;

      final oldIsBanned = _isBanned;
      final oldMemberRole = _memberRole;

      _isProcessingBan = true;
      try {
        if (_isBanned) {
          await nookRepository.unbanFollower(
            nookId: nookId,
            followerId: member.id,
          );
        } else {
          await nookRepository.banFollower(
            nookId: nookId,
            followerId: member.id,
          );
          _memberRole = MemberRole.member;
        }
        _isBanned = !_isBanned;

        emit(MemberUpdated(isBanned: _isBanned, memberRole: _memberRole));
      } catch (e) {
        _isBanned = oldIsBanned;
        _memberRole = oldMemberRole;
        emit(MemberUpdated(isBanned: _isBanned, memberRole: _memberRole));
      } finally {
        _isProcessingBan = false;
      }
    });

    on<MakeModerator>((event, emit) async {
      if (_isProcessingModerator) return;

      final oldMemberRole = _memberRole;

      _isProcessingModerator = true;
      try {
        if (_memberRole == MemberRole.moderator) {
          await nookRepository.deleteModerator(
            nookId: nookId,
            followerId: member.id,
          );
          _memberRole = MemberRole.member;
        } else {
          await nookRepository.createModerator(
            nookId: nookId,
            followerId: member.id,
          );
          _memberRole = MemberRole.moderator;
        }

        emit(MemberUpdated(isBanned: _isBanned, memberRole: _memberRole));
      } catch (e) {
        _memberRole = oldMemberRole;
        emit(MemberUpdated(isBanned: _isBanned, memberRole: _memberRole));
      } finally {
        _isProcessingModerator = false;
      }
    });
  }

  final NookRepository nookRepository;
  final NookMemberModel member;
  final String nookId;

  bool _isBanned = false;
  MemberRole _memberRole = MemberRole.member;

  bool _isProcessingBan = false;
  bool _isProcessingModerator = false;
}
