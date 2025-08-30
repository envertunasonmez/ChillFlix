import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/constants/string_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/cubit/auth/auth_cubit.dart';
import 'package:chillflix_app/cubit/auth/auth_state.dart';
import 'package:chillflix_app/views/auth/login/widgets/login_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  void _onListen(BuildContext context, AuthState state) {
    if (state.submissionSuccess) {
      Navigator.pushReplacementNamed(context, '/main');
      context.read<AuthCubit>().clearSubmissionFlag();
    }
    if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            backgroundColor: ColorConstants.redColor,
            content: Text(state.errorMessage!),
          ),
        );
    }
  }

  void _goToRegister(BuildContext context) {
    Navigator.pushNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    return Scaffold(
      backgroundColor: ColorConstants.blackColor,
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: _onListen,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(StringConstants.appName,
                      style: AppTextStyles.bodyStyle(
                          color: ColorConstants.blackColor,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                  LoginForm(),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => _goToRegister(context),
                    child: Text(
                      'Hesabın yok mu? Kayıt ol',
                      style: AppTextStyles.bodyStyle(
                          color: ColorConstants.whiteColor.withOpacity(0.7)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
