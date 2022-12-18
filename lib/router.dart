import 'package:flutter/material.dart';
import 'package:whatsappclone/features/auth/screens/login_screen.dart';
import 'package:whatsappclone/features/auth/screens/otp_screen.dart';
import 'package:whatsappclone/features/auth/screens/user_info.dart';
import 'package:whatsappclone/screens/mobile_layout_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => LoginScreen());
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OtpScreen(
                veficationId: verificationId,
              ));
    case UserInfoScreen.routeName:
      return MaterialPageRoute(builder: (context) => UserInfoScreen());
    case MobileLayoutScreen.routeName:
      return MaterialPageRoute(builder: (context) => MobileLayoutScreen());
    default:
      return MaterialPageRoute(builder: (context) => LoginScreen());
  }
}
