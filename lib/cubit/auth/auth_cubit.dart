import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthState());
  FirebaseAuth get _auth => FirebaseAuth.instance;
  void updateEmail(String value) {
    emit(state.copyWith(
        email: value, errorMessage: null, submissionSuccess: false));
  }

  void updatePassword(String value) {
    emit(state.copyWith(
        password: value, errorMessage: null, submissionSuccess: false));
  }

  void updateConfirmPassword(String value) {
    emit(state.copyWith(
        confirmPassword: value, errorMessage: null, submissionSuccess: false));
  }

  void togglePasswordObscure() {
    emit(state.copyWith(isPasswordObscured: !state.isPasswordObscured));
  }

  void toggleConfirmObscure() {
    emit(state.copyWith(isConfirmObscured: !state.isConfirmObscured));
  }

  bool _isValidEmail(String email) {
    final regex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');
    return regex.hasMatch(email.trim());
  }

  Future<void> submitLogin() async {
    if (!_isValidEmail(state.email)) {
      emit(state.copyWith(errorMessage: 'Geçerli bir email girin'));
      return;
    }
    if (state.password.length < 6) {
      emit(state.copyWith(errorMessage: 'Şifre en az 6 karakter olmalı'));
      return;
    }
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      await _auth.signInWithEmailAndPassword(
        email: state.email.trim(),
        password: state.password,
      );
      emit(state.copyWith(isSubmitting: false, submissionSuccess: true));
    } on FirebaseAuthException catch (e) {
      String msg = 'Bir hata oluştu';
      if (e.code == 'user-not-found') msg = 'Kullanıcı bulunamadı';
      if (e.code == 'wrong-password') msg = 'Şifre yanlış';
      if (e.code == 'invalid-email') msg = 'Geçersiz email';
      emit(state.copyWith(isSubmitting: false, errorMessage: msg));
    } catch (_) {
      emit(
          state.copyWith(isSubmitting: false, errorMessage: 'Giriş başarısız'));
    }
  }

  Future<void> submitRegister() async {
    if (!_isValidEmail(state.email)) {
      emit(state.copyWith(errorMessage: 'Geçerli bir email girin'));
      return;
    }
    if (state.password.length < 6) {
      emit(state.copyWith(errorMessage: 'Şifre en az 6 karakter olmalı'));
      return;
    }
    if (state.password != state.confirmPassword) {
      emit(state.copyWith(errorMessage: 'Şifreler eşleşmiyor'));
      return;
    }
    emit(state.copyWith(isSubmitting: true, errorMessage: null));
    try {
      await _auth.createUserWithEmailAndPassword(
        email: state.email.trim(),
        password: state.password,
      );
      emit(state.copyWith(isSubmitting: false, submissionSuccess: true));
    } on FirebaseAuthException catch (e) {
      String msg = 'Bir hata oluştu';
      if (e.code == 'email-already-in-use') msg = 'Email zaten kullanımda';
      if (e.code == 'weak-password') msg = 'Zayıf şifre';
      if (e.code == 'invalid-email') msg = 'Geçersiz email';
      emit(state.copyWith(isSubmitting: false, errorMessage: msg));
    } catch (_) {
      emit(
          state.copyWith(isSubmitting: false, errorMessage: 'Kayıt başarısız'));
    }
  }

  void clearSubmissionFlag() {
    if (state.submissionSuccess) {
      emit(state.copyWith(submissionSuccess: false));
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}
