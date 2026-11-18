import 'dart:io';

import 'package:facebook_clone/core/constants/app_colors.dart';
import 'package:facebook_clone/core/constants/constants.dart';
import 'package:facebook_clone/core/utils/utils.dart';
import 'package:facebook_clone/core/widgets/pick_image_widget.dart';
import 'package:facebook_clone/core/widgets/round_button.dart';
import 'package:facebook_clone/core/widgets/round_text_field.dart';
import 'package:facebook_clone/features/auth/presentation/widgets/birthday_picker.dart';
import 'package:facebook_clone/features/auth/presentation/widgets/gender_picker.dart';
import 'package:facebook_clone/features/auth/utils/utils.dart'
    show validateName, validateEmail, validatePassword;
import 'package:flutter/material.dart';

final _formKey = GlobalKey<FormState>();

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  File? image;
  DateTime? birthday; // Variable para almacenar la fecha de cumpleaños
  String? gender = 'Male'; // Variable para almacenar el género seleccionado

  // Controllers
  late final TextEditingController _fNameController;
  late final TextEditingController _lNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.realWhiteColor,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: Constants.defaultPadding,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    image = await pickImage();
                    setState(() {});
                  },
                  child: PickImageWidget(image: image),
                ), // GestureDetector
                const SizedBox(height: 20),
                Row(
                  children: [
                    // First Name Text Field
                    Expanded(
                      child: RoundTextField(
                        controller: _fNameController,
                        hintText: 'First name',
                        textInputAction: TextInputAction.next,
                        validator: validateName,
                      ), // RoundTextField
                    ), // Expanded
                    const SizedBox(width: 10),
                    // Last Name Text Field
                    Expanded(
                      child: RoundTextField(
                        controller: _lNameController,
                        hintText: 'Last name',
                        textInputAction: TextInputAction.next,
                        validator: validateName,
                      ), // RoundTextField
                    ), // Expanded
                  ],
                ), // Row
                const SizedBox(height: 20),
                BirthdayPicker(
                  dateTime: birthday ?? DateTime.now(),
                  onPressed: () async {
                    birthday = await pickSimpleDate(
                      context: context,
                      date: birthday,
                    );
                    setState(() {});
                  },
                ), // BirthdayPicker
                const SizedBox(height: 20),
                GenderPicker(
                  gender: gender,
                  onChanged: (value) {
                    gender = value ?? 'Male';
                    setState(() {}); // Update the UI when gender changes
                    // Handle gender selection
                  },
                ), // GenderPicker
                const SizedBox(height: 20),
                // Phone number / email text field
                RoundTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ), // RoundTextField
                const SizedBox(height: 20),
                // Password Text Field
                RoundTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  validator: validatePassword,
                  isPassword: true,
                ), // RoundTextField
                const SizedBox(height: 20),
                RoundButton(onPressed: () {}, label: 'Next'), // RoundButton
              ],
            ), // Column
          ), // Form
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
