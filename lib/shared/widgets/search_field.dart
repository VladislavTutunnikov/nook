import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    this.focusNode,
    this.controller,
    required this.isFocused,
    this.onChanged,
  });

  final FocusNode? focusNode;
  final bool isFocused;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      style: Theme.of(context).textTheme.titleLarge?.copyWith(
        fontWeight: FontWeight.w400,
        color: isFocused ? AppColors.black : AppColors.darkGrey,
      ),
      decoration: InputDecoration(
        hintText: S.of(context).search,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 5,
          ),
          child: SvgPicture.asset(
            AppIcons.search,
            colorFilter: ColorFilter.mode(
              isFocused ? AppColors.black : AppColors.darkGrey,
              BlendMode.srcIn,
            ),
          ),
        ),
        filled: true,
        fillColor: AppColors.blueGrey,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.darkGrey),
          borderRadius: BorderRadius.circular(1000),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.black, width: 1),
          borderRadius: BorderRadius.circular(1000),
        ),
      ),
    );
  }
}
