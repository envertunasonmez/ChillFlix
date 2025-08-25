import 'package:flutter/material.dart';

import 'package:chillflix_app/views/auth/login/widgets/email_field.dart';
import 'package:chillflix_app/views/auth/login/widgets/login_button.dart';
import 'package:chillflix_app/views/auth/login/widgets/password_field.dart';

class LoginForm extends StatelessWidget {
   LoginForm({super.key});
  final _formKey =  GlobalObjectKey<FormState>('login_form_key');

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const EmailField(),
          const SizedBox(height: 16),
          const PasswordField(),
          const SizedBox(height: 24),
          LoginButton(formKey: _formKey),
        ],
      ),
    );
  }
}
