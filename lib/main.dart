import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/l10n.dart';
import 'views/splash/splash_view.dart';
import 'main_wrapper.dart';
import 'cubit/locale/locale_cubit.dart';
import 'cubit/movies/movies_cubit.dart'; 
import 'views/auth/login/login_view.dart';
import 'views/auth/register/register_view.dart';
import 'cubit/auth/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocaleCubit()),
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => MoviesCubit()), 
      ],
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
            '/login': (context) => const LoginView(),
            '/register': (context) => const RegisterView(),
          },
        );
      },
    );
  }
}