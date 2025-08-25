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
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(color: Colors.white70),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white24)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) return 'Email gerekli';
            final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
            if (!emailRegex.hasMatch(value.trim())) {
              return 'Geçerli bir email girin';
            }
            return null;
          },
        );
      },
    );
  }
}
