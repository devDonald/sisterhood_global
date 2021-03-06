import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_images.dart';
import 'package:sisterhood_global/core/widgets/flat_primary_button.dart';
import 'package:sisterhood_global/core/widgets/flat_secodary_button.dart';
import 'package:sisterhood_global/core/widgets/primary_button.dart';
import 'package:sisterhood_global/core/widgets/screen_title.dart';
import 'package:sisterhood_global/core/widgets/social_button.dart';
import 'package:sisterhood_global/features/authentication/controller/auth_controller.dart';
import 'package:sisterhood_global/features/authentication/pages/register_screen.dart';
import 'package:sisterhood_global/features/authentication/pages/reset_password.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = AuthController.to;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  late ProgressDialog pr;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    pr = ProgressDialog(context);
    pr.style(message: 'Please wait, signing in');

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              // key: _formKey,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 39.8),
                    Center(
                      child: Column(
                        children: <Widget>[
                          Image.asset(
                            'images/logo.png',
                            width: 220,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 31.1),
                    const ScreenTitleIndicator(
                      title: 'LOGIN',
                    ),
                    const SizedBox(height: 25.9),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: ThemeColors.whiteColor,
                        borderRadius: BorderRadius.circular(2.5),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 7.5,
                            offset: Offset(0.0, 2.5),
                            color: ThemeColors.shadowColor,
                          )
                        ],
                      ),

                      width: double.infinity,
                      // width: double.infinity,
                      // height: 40.0,
                      child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          controller: _email,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.newline,
                          obscureText: false,
                          keyboardType: TextInputType.emailAddress,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.email),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      // padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: ThemeColors.whiteColor,
                        borderRadius: BorderRadius.circular(2.5),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 7.5,
                            offset: Offset(0.0, 2.5),
                            color: ThemeColors.shadowColor,
                          )
                        ],
                      ),
                      width: double.infinity,
                      // height: 40.0,
                      child: TextFormField(
                          style: const TextStyle(fontSize: 20),
                          controller: _password,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.newline,
                          obscureText: _obscureText,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.none,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          )),
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: FlatSecondaryButton(
                        title: 'Forgot Password? Click Here!',
                        color: ThemeColors.primaryPink200,
                        onTap: () {
                          Get.to(() => const ResetPassword());
                        },
                      ),
                    ),
                    const SizedBox(height: 25.0),
                    PrimaryButton(
                      width: double.infinity,
                      height: 45.0,
                      buttonTitle: 'Login',
                      color: ThemeColors.primaryColor,
                      blurRadius: 7.0,
                      roundedEdge: 10,
                      onTap: () async {
                        if (validateLogin(_email.text, _password.text)) {
                          authController.signIn(_email.text, _password.text);
                        }
                      },
                    ),
                    const SizedBox(height: 25.0),
                    SocialButton(
                      platformName: 'Continue with Google',
                      platformIcon: JanguAskImages.googleLogo,
                      color: ThemeColors.redColor,
                      onTap: () async {
                        authController.googleLogin();
                      },
                    ),
                    const SizedBox(height: 25.0),
                    Platform.isIOS
                        ? SignInWithAppleButton(
                            style: SignInWithAppleButtonStyle.black,
                            iconAlignment: IconAlignment.left,
                            onPressed: () {
                              authController.signInWithApple();
                            })
                        : Container(),
                    const SizedBox(height: 15.0),
                    Center(
                      child: FlatPrimaryButton(
                        info: 'Don\'t Have an Account? ',
                        title: 'Register',
                        onTap: () {
                          Get.offAll(() => RegisterScreen());
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 23.5,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
