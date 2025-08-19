import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  void startSplash() {
    Timer(const Duration(seconds: 3), () {
      emit(SplashFinished());
    });
  }
}
