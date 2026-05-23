import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/features/member_card/bloc/member_bloc.dart';
import 'package:nook/features/member_card/widgets/member_menu_bottom_sheet.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/avatar.dart';
import 'package:nook/shared/widgets/custom_icon_button.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class MemberCard extends StatefulWidget {
  const MemberCard({
    super.key,
    required this.member,
    this.showAsOwner = false,
    required this.nookId,
  });
  final NookMemberModel member;
  final String nookId;
  final bool showAsOwner;

  @override
  State<MemberCard> createState() => _MemberCardState();
}

class _MemberCardState extends State<MemberCard> {
  late final MemberBloc _memberBloc;

  @override
  void initState() {
    super.initState();
    _memberBloc = MemberBloc(
      nookRepository: getIt<NookRepository>(),
      member: widget.member,
      nookId: widget.nookId,
    );

    _memberBloc.add(SetupData());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberBloc, MemberState>(
      bloc: _memberBloc,
      builder: (context, state) {
        if (state is MemberUpdated) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(color: AppColors.lightGrey, width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => AutoRouter.of(
                      context,
                    ).push(AccountRoute(userId: widget.member.id)),
                    child: Row(
                      children: [
                        Avatar(avatarUrl: widget.member.avatarUrl ?? ''),
                        const SizedBox(width: 10),
                        SvgPicture.asset(
                          widget.showAsOwner
                              ? AppIcons.crown
                              : state.memberRole == MemberRole.moderator
                              ? AppIcons.sparkle
                              : AppIcons.user,
                          width: 18,
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Text(
                            widget.member.username,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                widget.member.canBan || widget.member.canMakeModerator
                    ? CustomIconButton(
                        iconPath: AppIcons.dots,
                        color: AppColors.black,
                        size: 22,
                        //TODO: add on tap
                        onTap: () => showModalBottomSheet(
                          context: context,
                          builder: (context) => MemberMenuBottomSheet(
                            showModerator: widget.member.canMakeModerator,
                            isBanned: state.isBanned,
                            isModerator:
                                state.memberRole == MemberRole.moderator,
                            onModeratorTap: () {
                              Navigator.pop(context);
                              _memberBloc.add(MakeModerator());
                            },
                            onBanTap: () {
                              Navigator.pop(context);
                              _memberBloc.add(BanMember());
                            },
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
