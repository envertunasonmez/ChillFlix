import 'package:chillflix_app/product/constants/assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/cubit/splash/splash_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashCubit()..startSplash(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashFinished) {
            final user = FirebaseAuth.instance.currentUser;
            if (user == null) {
              Navigator.pushReplacementNamed(context, '/login');
            } else {
              Navigator.pushReplacementNamed(context, '/main');
            }
          }
        },
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Image.asset(
              AssetsConstants.logo,
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
