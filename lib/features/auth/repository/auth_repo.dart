import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/common/repository/common_firebase_storage_repo.dart';
import 'package:whatsappclone/common/utils/utils.dart';
import 'package:whatsappclone/features/auth/screens/otp_screen.dart';
import 'package:whatsappclone/features/auth/screens/user_info.dart';
import 'package:whatsappclone/models/userModel.dart';
import 'package:whatsappclone/screens/mobile_layout_screen.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  AuthRepository({required this.auth, required this.firestore});

  Future<UserModel?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      print(userData.toString());
      //user=UserModel(name: userData, uid: uid, profilePic: profilePic, phoneNumber: phoneNumber, isOnline: isOnline, groupId: groupId)
    }
    return user;
  }

  void signInwithPhone(String phoneNumber, BuildContext context) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            await auth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (e) {
            throw Exception(e.message);
          },
          codeSent: ((String verificationId, int? resentToken) async {
            Navigator.pushNamed(context, OtpScreen.routeName,
                arguments: verificationId);
          }),
          codeAutoRetrievalTimeout: (String verificationId) {});
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      showSnackBar(context: context, content: e.message.toString());
    }
  }

  void verifyOtp(
      {required BuildContext ctx,
      required String verificationCode,
      required otp,
      VoidCallback? onSuccess}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationCode, smsCode: otp);
      await auth.signInWithCredential(credential);
      onSuccess?.call();
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: ctx, content: e.code);
    }
  }

  void saveUserInfoToFIrebase(
      {required name,
      required File? profilePic,
      required ProviderRef ref,
      required BuildContext context}) async {
    try {
      String uid = auth.currentUser!.uid;
      String photoUrl = 'https://cdn-icons-png.flaticon.com/512/149/149071.png';
      if (profilePic != null) {
        photoUrl = await ref
            .read(commonFirebaseStorageRepo)
            .storeImageToFirebase('profilePic/$uid', profilePic);
      }

      var user = UserModel(
          name: name,
          uid: uid,
          profilePic: photoUrl,
          isOnline: true,
          groupId: [],
          phoneNumber: auth.currentUser!.uid);
      await firestore.collection('users').doc(uid).set(user.toJson());
      Navigator.pushNamedAndRemoveUntil(
          context, MobileLayoutScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
