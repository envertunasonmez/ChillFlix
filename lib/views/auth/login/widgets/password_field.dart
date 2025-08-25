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
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'Şifre',
            labelStyle: const TextStyle(color: Colors.white70),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white24)),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red)),
            suffixIcon: IconButton(
              icon: Icon(
                state.isPasswordObscured
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Colors.white70,
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
