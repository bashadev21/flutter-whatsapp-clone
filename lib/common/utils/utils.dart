import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../colors.dart';

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    duration: const Duration(seconds: 2),
  ));
}

Future<File?> pickImage(BuildContext context, ImageSource imageSource) async {
  File? image;

  try {
    final pickedImg = await ImagePicker().pickImage(source: imageSource);
    if (pickedImg != null) {
      image = File(pickedImg.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

InputBorder whiteLineDecoration = const UnderlineInputBorder(
  borderSide: BorderSide(color: Colors.white, width: 1.0),
);
InputBorder greenLineDecoration = const UnderlineInputBorder(
  borderSide: BorderSide(color: tabColor, width: 2.0),
);
