import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/colors.dart';
import 'package:whatsappclone/common/utils/utils.dart';
import 'package:whatsappclone/common/widgets/custome_btn.dart';
import 'package:whatsappclone/features/auth/controller/auth_controller.dart';

import 'otp_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static const routeName = '/login-screeen';
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  void sendPhoneNumber() {
    String phoneNumber = _phoneController.text.trim();
    if (phoneNumber.length == 10) {
      ref
          .read(authControllerProvider)
          .authRepository
          .signInwithPhone('+91$phoneNumber', context);
    } else {
      showSnackBar(context: context, content: 'Enter valid Mobile Number');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter your phone number")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Text(
                    'We will send the verification code below entering number'),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _phoneController,
                  cursorColor: tabColor,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {});
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    counterText: '',
                    labelText: "Enter Mobile",
                    prefixText: '+91',
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: tabColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: tabColor, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
                width: 130,
                child: CustomBtn(onPress: sendPhoneNumber, title: 'NEXT'))
          ],
        ),
      ),
    );
  }
}
