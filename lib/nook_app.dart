import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/router/router.dart';
import 'package:nook/theme/theme.dart';

class NookApp extends StatefulWidget {
  const NookApp({super.key});

  @override
  State<NookApp> createState() => _NookAppState();
}

class _NookAppState extends State<NookApp> {

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Nook',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: whiteTheme,
      routerConfig: _appRouter.config(),
    );
  }
}
