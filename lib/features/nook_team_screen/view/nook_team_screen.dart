import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/features/member_card/widgets/member_card.dart';
import 'package:nook/features/nook_team_screen/bloc/nook_team_bloc.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/theme/colors.dart';

@RoutePage()
class NookTeamScreen extends StatefulWidget {
  const NookTeamScreen({super.key, required this.nookId});
  final String nookId;

  @override
  State<NookTeamScreen> createState() => _NookTeamScreenState();
}

class _NookTeamScreenState extends State<NookTeamScreen> {
  late final NookTeamBloc _nookTeamBloc;

  @override
  void initState() {
    super.initState();
    _nookTeamBloc = NookTeamBloc(
      nookRepository: getIt<NookRepository>(),
      nookId: widget.nookId,
    );
    _nookTeamBloc.add(LoadNookTeam());
  }

  Future<void> _onRefresh() async {
    _nookTeamBloc.add(LoadNookTeam());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NookTeamBloc, NookTeamState>(
        bloc: _nookTeamBloc,
        builder: (context, state) {
          if (state is NookTeamLoaded) {
            return RefreshIndicator(
              backgroundColor: AppColors.white,
              color: AppColors.black,
              onRefresh: _onRefresh,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 60, left: 15),
                      child: CustomBackButton(color: AppColors.black),
                    ),
                    const SizedBox(height: 25),

                    state.owner != null
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              bottom: 10,
                            ),
                            child: Text(
                              S.of(context).nookOwner,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          )
                        : const SizedBox(),

                    state.owner != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: MemberCard(
                              member: state.owner!,
                              nookId: widget.nookId,
                              showAsOwner: true,
                            ),
                          )
                        : const SizedBox(),

                    state.moderators?.isNotEmpty == true
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 25,
                              bottom: 10,
                            ),
                            child: Text(
                              S.of(context).nookModerators,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          )
                        : const SizedBox(),
                    state.moderators?.isNotEmpty == true
                        ? ListView.builder(
                            padding: const EdgeInsets.all(0),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: state.moderators!.length,
                            itemBuilder: (context, index) => MemberCard(
                              member: state.moderators![index],
                              nookId: widget.nookId,
                            ),
                          )
                        : const SizedBox(),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            );
          } else if (state is NookTeamLoadingFailure) {
            return Center(child: ErrorMessage(onTap: _onRefresh));
          } else {
            return const Center(child: LoadingDots());
          }
        },
      ),
    );
  }
}
