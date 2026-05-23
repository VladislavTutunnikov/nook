import 'package:flutter/material.dart';
import 'package:nook/api/models/nook_member_model.dart';
import 'package:nook/features/member_card/widgets/member_card.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/loading_dots.dart';

class FollowersList extends StatelessWidget {
  const FollowersList({
    super.key,
    required this.followers,
    required this.nookId,
    this.showLoading = false,
  });
  final List<NookMemberModel> followers;
  final String nookId;
  final bool showLoading;

  @override
  Widget build(BuildContext context) {
    return followers.isEmpty
        ? Padding(
            padding: const EdgeInsetsGeometry.only(left: 25),
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
                itemCount: followers.length,
                itemBuilder: (context, index) =>
                    MemberCard(member: followers[index], nookId: nookId),
              ),

              showLoading ? const LoadingDots() : const SizedBox(height: 60),
            ],
          );
  }
}
