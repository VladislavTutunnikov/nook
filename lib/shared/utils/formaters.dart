import 'package:flutter/material.dart';
import 'package:nook/generated/l10n.dart';

class Formaters {
  static String formatTime(DateTime dateTime, BuildContext context) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()} ${S.of(context).years}';
    }
    if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()} ${S.of(context).months}';
    }
    if (difference.inDays > 0) {
      return '${difference.inDays} ${S.of(context).days}';
    }
    if (difference.inHours > 0) {
      return '${difference.inHours} ${S.of(context).hours}';
    }
    if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${S.of(context).minutes}';
    }
    return S.of(context).justNow;
  }

  static String formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}k';
    } else {
      return number.toString();
    }
  }
}
