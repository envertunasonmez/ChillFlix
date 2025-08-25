import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final String email;
  final String password;
  final String confirmPassword;
  final bool isPasswordObscured;
  final bool isConfirmObscured;
  final bool isSubmitting;
  final String? errorMessage;
  final bool submissionSuccess;

  const AuthState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordObscured = true,
    this.isConfirmObscured = true,
    this.isSubmitting = false,
    this.errorMessage,
    this.submissionSuccess = false,
  });

  AuthState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isPasswordObscured,
    bool? isConfirmObscured,
    bool? isSubmitting,
    String? errorMessage,
    bool? submissionSuccess,
  }) {
    return AuthState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordObscured: isPasswordObscured ?? this.isPasswordObscured,
      isConfirmObscured: isConfirmObscured ?? this.isConfirmObscured,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: errorMessage,
      submissionSuccess: submissionSuccess ?? this.submissionSuccess,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        isPasswordObscured,
        isConfirmObscured,
        isSubmitting,
        errorMessage,
        submissionSuccess,
      ];
}
