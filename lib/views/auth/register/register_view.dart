import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/cubit/auth/auth_cubit.dart';
import 'package:chillflix_app/cubit/auth/auth_state.dart';
import 'widgets/register_form.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  void _onListen(BuildContext context, AuthState state) {
    if (state.submissionSuccess) {
      Navigator.pushReplacementNamed(context, '/login');
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

  void _goToLogin(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                  Text(
                    'ChillFlix',
                    style: AppTextStyles.headLineStyle(
                        color: ColorConstants.redColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  const RegisterForm(),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => _goToLogin(context),
                    child: Text('Zaten hesabın var mı? Giriş yap',
                        style: AppTextStyles.bodyStyle(
                            color: ColorConstants.whiteColor.withOpacity(0.7))),
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
