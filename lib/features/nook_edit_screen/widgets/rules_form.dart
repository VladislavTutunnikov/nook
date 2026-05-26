import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/colors.dart';

class RulesForm extends StatelessWidget {
  const RulesForm({super.key, this.rulesController});
  final TextEditingController? rulesController;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: BoxBorder.all(width: 1, color: AppColors.lightGrey),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        children: [
          TextField(
            controller: rulesController,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: null,
            decoration: InputDecoration(
              hintText: S.of(context).nookRules,
              hintStyle: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.darkGrey),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.transparent),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.transparent),
              ),
            ),
          ),
        ],
      ),
    );
  }
}