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
            backgroundColor: Colors.red,
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
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: _onListen,
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('ChillFlix',
                      style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.red, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 24),
                   LoginForm(),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => _goToRegister(context),
                    child: const Text(
                      'Hesabın yok mu? Kayıt ol',
                      style: TextStyle(color: Colors.white70),
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
