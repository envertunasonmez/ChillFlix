import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/cubit/auth/auth_cubit.dart';
import 'package:chillflix_app/cubit/auth/auth_state.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
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
                    if (formKey.currentState!.validate()) {
                      context.read<AuthCubit>().submitLogin();
                    }
                  },
            child: state.isSubmitting
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: ColorConstants.whiteColor),
                  )
                : const Text('Giriş Yap'),
          ),
        );
      },
    );
  }
}
