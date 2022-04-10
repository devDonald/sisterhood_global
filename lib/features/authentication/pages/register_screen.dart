import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_images.dart';
import 'package:sisterhood_global/core/widgets/country_code_button.dart';
import 'package:sisterhood_global/core/widgets/flat_primary_button.dart';
import 'package:sisterhood_global/core/widgets/primary_button.dart';
import 'package:sisterhood_global/core/widgets/screen_title.dart';
import 'package:sisterhood_global/core/widgets/social_button.dart';
import 'package:sisterhood_global/features/authentication/pages/login_screen.dart';

import '../controller/auth_controller.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController authController = AuthController.to;

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();

  final TextEditingController _fullName = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();

  String _dialCode = '+234', _country = 'Nigeria', _code = 'NG';

  String? marital;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Column(
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
                        const SizedBox(height: 22.1),
                        const ScreenTitleIndicator(
                          title: 'Register',
                        ),
                        const SizedBox(
                          height: 20.9,
                        ),
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
                              controller: _fullName,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              textInputAction: TextInputAction.newline,
                              keyboardType: TextInputType.text,
                              textCapitalization: TextCapitalization.words,
                              maxLength: null,
                              decoration: InputDecoration(
                                hintText: 'Full Name',
                                prefixIcon: const Icon(Icons.person),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              )),
                        ),
                        const SizedBox(height: 15),
                        //email
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.newline,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              prefixIcon: const Icon(Icons.email),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

                        //Marital Status
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: ThemeColors.whiteColor,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 7.5,
                                offset: Offset(0.0, 2.5),
                                color: ThemeColors.shadowColor,
                              )
                            ],
                          ),
                          child: DropDown(
                            dropDownType: DropDownType.Button,
                            items: const [
                              "Single",
                              "Married",
                              "Widowed",
                              "Divorced"
                            ],
                            hint: const Text("Marital Status"),
                            icon: const Icon(
                              Icons.expand_more,
                              color: Colors.pink,
                            ),
                            onChanged: (String? value) {
                              marital = value!;
                            },
                          ),
                        ),
                        //password
                        const SizedBox(height: 15),
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.newline,
                            obscureText: _obscureText,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.none,
                            maxLength: null,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              prefixIcon: const Icon(Icons.lock),
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
                              contentPadding:
                                  const EdgeInsets.fromLTRB(20, 15, 20, 15),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),

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
                            controller: _confirmPassword,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.newline,
                            obscureText: _obscureText,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.none,
                            maxLength: null,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
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
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        //phone
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: CountryCodeButton(
                                      height: 60,
                                      onSelectCode: (String dialCode,
                                          String flagUri, String country) {
                                        _dialCode = dialCode;
                                        _country = country;
                                        _code = flagUri;
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    flex: 2,
                                    child: SizedBox(
                                      child: Container(
                                        // padding: EdgeInsets.symmetric(horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: ThemeColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(2.5),
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
                                          controller: _phoneNumber,
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.phone,
                                          textCapitalization:
                                              TextCapitalization.none,
                                          decoration: InputDecoration(
                                            hintText: 'Phone Number',
                                            prefixIcon: const Icon(Icons.phone),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    20, 15, 20, 15),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 25.0),
                        PrimaryButton(
                          height: 45.0,
                          width: double.infinity,
                          color: ThemeColors.primaryColor,
                          buttonTitle: 'Create an account',
                          blurRadius: 7.0,
                          roundedEdge: 2.5,
                          onTap: () async {
                            if (validateForm(
                                _email.text,
                                _fullName.text,
                                _password.text,
                                _country,
                                _dialCode,
                                _code,
                                _phoneNumber.text,
                                _confirmPassword.text)) {
                              UserModel model = UserModel(
                                name: _fullName.text,
                                country: _country,
                                photo: profilePHOTO,
                                email: _email.text,
                                phone: _phoneNumber.text,
                                dialCode: _dialCode,
                                code: _code,
                                marital: marital,
                                bio: "I am new to sisterhood global App",
                                followersList: {},
                                followingList: {},
                                type: "USER",
                                isAdmin: false,
                                posts: 0,
                              );
                              authController.signUp(
                                  _email.text, _password.text, model);
                            }
                          },
                        ),
                        const SizedBox(height: 25.0),

                        SocialButton(
                          platformName: 'Sign up with Google',
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
                        //
                        const SizedBox(height: 15.0),
                        Center(
                          child: FlatPrimaryButton(
                            info: 'Have an Account? ',
                            title: 'Login',
                            onTap: () {
                              Get.offAll(() => LoginScreen());
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 23.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
