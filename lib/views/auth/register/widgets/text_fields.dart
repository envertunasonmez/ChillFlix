import 'package:chillflix_app/product/constants/color_constants.dart';
import 'package:chillflix_app/product/init/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chillflix_app/cubit/auth/auth_cubit.dart';
import 'package:chillflix_app/cubit/auth/auth_state.dart';

class EmailField extends StatelessWidget {
  const EmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) => p.email != c.email,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.email,
          onChanged: context.read<AuthCubit>().updateEmail,
          keyboardType: TextInputType.emailAddress,
          style: AppTextStyles.buttonStyle(color: ColorConstants.whiteColor),
          decoration: const InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: ColorConstants.whiteColor),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.whiteColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.redColor)),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Email gerekli';
            final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
            if (!emailRegex.hasMatch(value.trim()))
              return 'Geçerli bir email girin';
            return null;
          },
        );
      },
    );
  }
}

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
          style: TextStyle(color: ColorConstants.whiteColor),
          decoration: InputDecoration(
            labelText: 'Şifre',
            labelStyle: TextStyle(color: ColorConstants.whiteColor),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.greyColor)),
            focusedBorder: const OutlineInputBorder(
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

class ConfirmPasswordField extends StatelessWidget {
  const ConfirmPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (p, c) =>
          p.confirmPassword != c.confirmPassword ||
          p.isConfirmObscured != c.isConfirmObscured ||
          p.password != c.password,
      builder: (context, state) {
        return TextFormField(
          initialValue: state.confirmPassword,
          onChanged: context.read<AuthCubit>().updateConfirmPassword,
          obscureText: state.isConfirmObscured,
          style: const TextStyle(color: ColorConstants.whiteColor),
          decoration: InputDecoration(
            labelText: 'Şifre (Tekrar)',
            labelStyle: const TextStyle(color: ColorConstants.whiteColor),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.greyColor)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.redColor)),
            suffixIcon: IconButton(
              icon: Icon(
                state.isConfirmObscured
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: ColorConstants.whiteColor,
              ),
              onPressed: context.read<AuthCubit>().toggleConfirmObscure,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Şifre tekrar gerekli';
            if (value != state.password) return 'Şifreler eşleşmiyor';
            return null;
          },
        );
      },
    );
  }
}
