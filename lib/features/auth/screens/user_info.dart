import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whatsappclone/features/auth/controller/auth_controller.dart';

import '../../../colors.dart';
import '../../../common/utils/utils.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  static const routeName = '/user-info';
  const UserInfoScreen({super.key});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  File? image;
  final TextEditingController nameController = TextEditingController();
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  void selectImage() async {
    image = await pickImage(context, ImageSource.gallery);
    setState(() {});
  }

  void storeUserInfo() async {
    String name = nameController.text.trim();
    if (name.isNotEmpty) {
      ref.read(authControllerProvider).saveUserData(context, name, image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    image == null
                        ? const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: FileImage(image!),
                          ),
                    Positioned(
                      bottom: 3,
                      right: 3,
                      child: InkWell(
                        onTap: selectImage,
                        child: Icon(
                          image == null
                              ? Icons.add_a_photo
                              : Icons.photo_camera,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: nameController,
                        onChanged: (value) {},
                        cursorHeight: 25,
                        cursorColor: tabColor,
                        decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Enter your name',
                            focusedBorder: greenLineDecoration,
                            enabledBorder: whiteLineDecoration,
                            disabledBorder: greenLineDecoration,
                            border: whiteLineDecoration),
                      ),
                    ),
                    IconButton(
                        onPressed: storeUserInfo,
                        icon: const Icon(
                          Icons.check,
                          color: tabColor,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
