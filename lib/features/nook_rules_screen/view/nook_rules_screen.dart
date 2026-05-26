import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/theme/colors.dart';

@RoutePage()
class NookRulesScreen extends StatelessWidget {
  const NookRulesScreen({super.key, this.rules});

  final String? rules;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomBackButton(color: AppColors.black),
              const SizedBox(height: 25),
              SelectableText(
                rules != null && rules != ''
                    ? rules!
                    : S.of(context).theresNothingHere,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
