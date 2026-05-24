import 'package:flutter/material.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/nook_card.dart';

class NookList extends StatelessWidget {
  const NookList({
    super.key,
    required this.nooks,
    this.showLoading = false,
    this.placeholderTextAlign,
    this.placeholderTextPadding = const EdgeInsets.only(left: 25),
    this.placeholderText,
  });

  final List<NookModel> nooks;
  final bool showLoading;
  final TextAlign? placeholderTextAlign;
  final EdgeInsetsGeometry placeholderTextPadding;
  final String? placeholderText;

  @override
  Widget build(BuildContext context) {
    return nooks.isEmpty
        ? Padding(
            padding: placeholderTextPadding,
            child: Text(
              textAlign: placeholderTextAlign,
              placeholderText ?? S.of(context).theresNothingHere,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        : Column(
            children: [
              ListView.builder(
                addAutomaticKeepAlives: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: nooks.length,
                itemBuilder: (context, index) {
                  return NookCard(nook: nooks[index]);
                },
              ),

              showLoading ? const LoadingDots() : const SizedBox(height: 40),
            ],
          );
  }
}
