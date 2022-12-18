import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/features/auth/repository/auth_repo.dart';

import '../screens/user_info.dart';

final authControllerProvider = Provider((ref) {
  final authReposotry = ref.watch(authRepositoryProvider);
  return AuthController(authRepository: authReposotry, ref: ref);
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({
    required this.authRepository,
    required this.ref,
  });

  void signInwithPhone(phoneNumber, BuildContext context) {
    authRepository.signInwithPhone(phoneNumber, context);
  }

  void verifyOtp(BuildContext context, verificationCode, otp) {
    authRepository.verifyOtp(
        ctx: context,
        verificationCode: verificationCode,
        otp: otp,
        onSuccess: () {
          Navigator.pushNamedAndRemoveUntil(
              context, UserInfoScreen.routeName, (route) => false);
        });
  }

  void saveUserData(BuildContext context, String name, File profilePic) {
    authRepository.saveUserInfoToFIrebase(
        name: name, profilePic: profilePic, ref: ref, context: context);
  }
}
