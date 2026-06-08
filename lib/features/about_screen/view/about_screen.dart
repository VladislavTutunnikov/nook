import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/theme/colors.dart';

@RoutePage()
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60, left: 15, bottom: 25),
            child: CustomBackButton(color: AppColors.black),
          ),
          //TODO: replace real text with localization
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SelectableText(
              '''О компании Nook

Nook — это молодая команда, создающая пространство для общения по интересам.

Мы верим, что у каждого должно быть место, где можно делиться тем, что действительно важно. Без лишнего шума, без навязчивой рекламы — просто уютный уголок для единомышленников.

Наша миссия — помочь людям находить друзей и сообщества по увлечениям: от мемов и музыки до технологий и творчества.

Nook создан с любовью к деталям и уважением к каждому пользователю.

Присоединяйтесь к нам в социальных сетях:
• Telegram: t.me/nook_app
• Почта: support@nook.com

© 2026 Nook. Все права защищены.''',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
