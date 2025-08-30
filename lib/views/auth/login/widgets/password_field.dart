import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/cubit/auth/auth_cubit.dart';
import 'package:chillflix_app/cubit/auth/auth_state.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) =>
          p.password != c.password ||
          p.isPasswordObscured != c.isPasswordObscured,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.password,
          onChanged: context.read<AuthCubit>().updatePassword,
          obscureText: state.isPasswordObscured,
          style:  AppTextStyles.buttonStyle(color: ColorConstants.whiteColor),
          decoration: InputDecoration(
            labelText: 'Şifre',
            labelStyle:  TextStyle(color: ColorConstants.whiteColor),
            enabledBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.whiteColor)),
            focusedBorder:  OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.redColor)),
            suffixIcon: IconButton(
              icon: Icon(
                state.isPasswordObscured
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: ColorConstants.whiteColor,
              ),
              onPressed: context.read<AuthCubit>().togglePasswordObscure,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Şifre gerekli';
            if (value.length < 6) return 'Şifre en az 6 karakter olmalı';
            return null;
          },
        );
      },
    );
  }
}
