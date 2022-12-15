import 'package:flutter/material.dart';

import '../../../common/widgets/custome_btn.dart';
import '../../auth/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);
  void navigateToLogin(BuildContext context) {
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 70,
            ),
            const Text(
              "Welcome To Whatsapp",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 26),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * .73,
              child: CustomBtn(
                onPress: () {
                  navigateToLogin(context);
                },
                title: 'AGREE AND CONTINUE',
              ),
            )
          ],
        ),
      ),
    );
  }
}
