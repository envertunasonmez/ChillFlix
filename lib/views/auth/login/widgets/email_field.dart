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
          style: AppTextStyles.headLineStyle(color: ColorConstants.whiteColor),
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle:
                AppTextStyles.bodyStyle(color: ColorConstants.whiteColor),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorConstants.whiteColor)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: ColorConstants.redColor)),
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
