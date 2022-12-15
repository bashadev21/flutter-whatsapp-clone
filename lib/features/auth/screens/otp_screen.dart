import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsappclone/features/auth/controller/auth_controller.dart';

import '../../../colors.dart';

class OtpScreen extends ConsumerStatefulWidget {
  static const String routeName = '/otp-screen';
  final String veficationId;
  const OtpScreen({super.key, required this.veficationId});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  void verifyOtp(otp) {
    ref
        .read(authControllerProvider)
        .verifyOtp(context, widget.veficationId, otp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Otp'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text('Enter the otp we sent'),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                textAlign: TextAlign.center,
                maxLength: 6,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (value.length == 6) {
                    verifyOtp(value);
                  }
                },
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                cursorHeight: 25,
                cursorColor: tabColor,
                style: const TextStyle(letterSpacing: 5),
                decoration: InputDecoration(
                    counterText: '',
                    hintText: '-  -  -  -  -  -',
                    hintStyle: TextStyle(fontSize: 30, letterSpacing: 0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: tabColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    ),
                    disabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: tabColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
