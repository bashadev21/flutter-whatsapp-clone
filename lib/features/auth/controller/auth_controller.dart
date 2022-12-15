import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/features/auth/repository/auth_repo.dart';

final authControllerProvider = Provider((ref) {
  final authReposotry = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authReposotry);
});

class AuthController {
  final AuthRepository authRepository;

  AuthController({required this.authRepository});

  void signInwithPhone(phoneNumber, BuildContext context) {
    authRepository.signInwithPhone(phoneNumber, context);
  }

  void verifyOtp(BuildContext context, verificationCode, otp) {
    authRepository.verifyOtp(
        context: context, verificationCode: verificationCode, otp: otp);
  }
}
