import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:whatsappclone/colors.dart';

class CustomBtn extends StatelessWidget {
  final VoidCallback onPress;
  final String title;

  const CustomBtn({super.key, required this.onPress, required this.title});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      child: Text(title),
      style: ElevatedButton.styleFrom(
          backgroundColor: tabColor, minimumSize: Size(double.infinity, 48)),
    );
  }
}
