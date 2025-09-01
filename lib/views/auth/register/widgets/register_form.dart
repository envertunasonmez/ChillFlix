import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/cubit/auth/auth_cubit.dart';
import 'package:chillflix_app/cubit/auth/auth_state.dart';
import 'text_fields.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Column(
        children: [
          EmailField(),
          const SizedBox(height: 16),
          PasswordField(),
          const SizedBox(height: 16),
          ConfirmPasswordField(),
          const SizedBox(height: 24),
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (p, c) => p.isSubmitting != c.isSubmitting,
            builder: (context, state) {
              return SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstants.redColor,
                    foregroundColor: ColorConstants.whiteColor,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            context.read<AuthCubit>().submitRegister();
                          }
                        },
                  child: state.isSubmitting
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: ColorConstants.whiteColor))
                      : const Text('Kayıt Ol'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
