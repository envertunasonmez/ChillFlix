import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'views/splash/splash_view.dart';
import 'main_wrapper.dart';
import 'cubit/locale/locale_cubit.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => LocaleCubit(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          title: 'ChillFlix',
          debugShowCheckedModeBanner: false,
          locale: locale,
          supportedLocales: S.delegate.supportedLocales,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(useMaterial3: true),
          darkTheme: ThemeData.dark(),
          home: const SplashView(),
          routes: {
            '/main': (context) => const MainWrapper(),
          },
        );
      },
    );
  }
}
