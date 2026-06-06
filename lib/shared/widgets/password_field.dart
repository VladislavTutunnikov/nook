import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.keyboardType,
    this.focusNode,
    this.obscuringCharacter = '•',
  });

  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;
  final String obscuringCharacter;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class TextInputFormatter {}

class _PasswordFieldState extends State<PasswordField> {
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      style: Theme.of(context).textTheme.bodyLarge,
      focusNode: widget.focusNode,
      obscureText: _isObscured,
      obscuringCharacter: widget.obscuringCharacter,
      decoration: InputDecoration(
        suffixIcon: GestureDetector(
          onTap: () => setState(() {
            _isObscured = !_isObscured;
          }),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset(
              _isObscured ? AppIcons.eyeClosed : AppIcons.eye,
              colorFilter: const ColorFilter.mode(
                AppColors.darkGrey,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        hint: Text(
          S.of(context).password,
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(color: AppColors.darkGrey),
        ),
      ),
    );
  }
}
