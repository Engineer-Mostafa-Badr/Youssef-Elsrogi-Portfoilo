import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/app_state.dart';
import 'core/theme.dart';
import 'home_page.dart';

void main() {
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  final _app = AppController();

  @override
  Widget build(BuildContext context) {
    return AppScope(
      controller: _app,
      child: ListenableBuilder(
        listenable: _app,
        builder: (context, _) => MaterialApp(
          title: 'Youssef Elsrogi — Backend Laravel Developer',
          debugShowCheckedModeBanner: false,
          theme: buildTheme(dark: _app.dark, ar: _app.ar),
          locale: Locale(_app.ar ? 'ar' : 'en'),
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          home: const HomePage(),
        ),
      ),
    );
  }
}
