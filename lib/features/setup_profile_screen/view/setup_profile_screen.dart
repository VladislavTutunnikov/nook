import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/user_repository.dart';
import 'package:nook/features/setup_profile_screen/bloc/setup_profile_bloc.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/shared/widgets/capsule_button.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class SetupProfileScreen extends StatefulWidget {
  const SetupProfileScreen({super.key});

  @override
  State<SetupProfileScreen> createState() => _SetupProfileScreenState();
}

class _SetupProfileScreenState extends State<SetupProfileScreen> {
  final SetupProfileBloc _setupProfileBloc = SetupProfileBloc(
    userRepository: getIt<UserRepository>(),
  );

  DateTime? _lastPressed;

  @override
  void initState() {
    super.initState();
    _setupProfileBloc.add(GetCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final now = DateTime.now();

        if (_lastPressed == null ||
            now.difference(_lastPressed!) > const Duration(seconds: 2)) {
          _lastPressed = now;
          return;
        }

        await SystemNavigator.pop();
      },
      child: Scaffold(
        body: BlocBuilder<SetupProfileBloc, SetupProfileState>(
          bloc: _setupProfileBloc,
          builder: (context, state) {
            if (state is SetupProfileLoaded) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 20,
                      right: 20,
                      bottom: 20,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(color: AppColors.lightGrey, width: 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(AppIcons.face, width: 40),
                        const SizedBox(height: 10),
                        Text(
                          S.of(context).letsSetupYourProfile,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),

                        const SizedBox(height: 20),
                        CapsuleButton(
                          text: S.of(context).proceed,
                          padding: const EdgeInsets.all(13),
                          centerText: true,
                          textStyle: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(color: AppColors.white),
                          onTap: () async {
                            final bool? isProfileEdited =
                                await AutoRouter.of(context).push<bool>(
                                  UserProfileEditRoute(user: state.user),
                                );

                            if (isProfileEdited == true) {
                              AutoRouter.of(
                                context,
                              ).replaceAll([const MainRoute()]);
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        CapsuleButton(
                          text: S.of(context).skip,
                          padding: const EdgeInsets.all(13),
                          centerText: true,
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          backgroundColor: AppColors.white,
                          border: Border.all(width: 1, color: AppColors.black),
                          onTap: () => AutoRouter.of(
                            context,
                          ).replaceAll([const MainRoute()]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state is SetupProfileLoadingFailure) {
              return Center(
                child: ErrorMessage(
                  onTap: () => _setupProfileBloc.add(GetCurrentUser()),
                ),
              );
            } else {
              return const Center(child: LoadingDots());
            }
          },
        ),
      ),
    );
  }
}
