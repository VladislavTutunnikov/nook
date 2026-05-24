import 'package:flutter/material.dart';
import 'package:nook/api/models/nook_model.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/nook_card.dart';

class NookList extends StatelessWidget {
  const NookList({super.key, required this.nooks, this.showLoading = false});

  final List<NookModel> nooks;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return nooks.isEmpty
        ? Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              S.of(context).theresNothingHere,
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
