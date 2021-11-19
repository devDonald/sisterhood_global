import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';
import 'package:sisterhood_global/core/routes/app_pages.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_images.dart';
import 'package:sisterhood_global/core/widgets/country_code_button.dart';
import 'package:sisterhood_global/core/widgets/flat_primary_button.dart';
import 'package:sisterhood_global/core/widgets/primary_button.dart';
import 'package:sisterhood_global/core/widgets/screen_title.dart';
import 'package:sisterhood_global/core/widgets/social_button.dart';
import 'package:sisterhood_global/features/authentication/controller/login_controller.dart';

class RegisterScreen extends GetWidget<AuthController> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _confirmPassword = TextEditingController();

  final TextEditingController _fullName = TextEditingController();

  final TextEditingController _phoneNumber = TextEditingController();

  String _dialCode = '+234', _country = 'Nigeria', _code = 'NG';

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
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
                        SizedBox(height: 22.1),
                        const ScreenTitleIndicator(
                          title: 'Register',
                        ),
                        const SizedBox(
                          height: 20.9,
                        ),
                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: JanguAskColors.whiteColor,
                            borderRadius: BorderRadius.circular(2.5),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 7.5,
                                offset: Offset(0.0, 2.5),
                                color: JanguAskColors.shadowColor,
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
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Full Name',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        //email
                        Container(
                          // padding: EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: JanguAskColors.whiteColor,
                            borderRadius: BorderRadius.circular(2.5),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 7.5,
                                offset: Offset(0.0, 2.5),
                                color: JanguAskColors.shadowColor,
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
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Email Id',
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                            ),
                          ),
                        ),
                        //password
                        const SizedBox(height: 15),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: JanguAskColors.whiteColor,
                                  borderRadius: BorderRadius.circular(2.5),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 7.5,
                                      offset: Offset(0.0, 2.5),
                                      color: JanguAskColors.shadowColor,
                                    )
                                  ],
                                ),
                                width:
                                    MediaQuery.of(context).size.width / 2.3 + 1,
                                // width: double.infinity,
                                // height: 40.0,
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 20),
                                  controller: _password,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.newline,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.none,
                                  maxLength: null,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Password',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                ),
                              ),
                              Container(
                                // padding: EdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  color: JanguAskColors.whiteColor,
                                  borderRadius: BorderRadius.circular(2.5),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 7.5,
                                      offset: Offset(0.0, 2.5),
                                      color: JanguAskColors.shadowColor,
                                    )
                                  ],
                                ),
                                width:
                                    MediaQuery.of(context).size.width / 2.3 + 1,
                                // width: double.infinity,
                                // height: 40.0,
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 20),
                                  controller: _confirmPassword,
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  textInputAction: TextInputAction.newline,
                                  obscureText: true,
                                  keyboardType: TextInputType.text,
                                  textCapitalization: TextCapitalization.none,
                                  maxLength: null,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Confirm Password',
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                ),
                              ),
                            ],
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
                                  SizedBox(width: 15),
                                  Flexible(
                                    flex: 2,
                                    child: SizedBox(
                                      height: 65,
                                      child: Container(
                                        // padding: EdgeInsets.symmetric(horizontal: 15),
                                        decoration: BoxDecoration(
                                          color: JanguAskColors.whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(2.5),
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 7.5,
                                              offset: Offset(0.0, 2.5),
                                              color: JanguAskColors.shadowColor,
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
                                          decoration: const InputDecoration(
                                            border: InputBorder.none,
                                            hintText: 'Phone number',
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    horizontal: 10),
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
                          color: JanguAskColors.primaryColor,
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
                                type: "USER",
                              );
                              controller.signUp(
                                  _email.text, _password.text, model);
                            }
                          },
                        ),
                        const SizedBox(height: 25.0),

                        SocialButton(
                          platformName: 'Sign up with Google',
                          platformIcon: JanguAskImages.googleLogo,
                          color: JanguAskColors.redColor,
                          onTap: () async {
                            controller.googleLogin();
                          },
                        ),
                        //
                        const SizedBox(height: 15.0),
                        Center(
                          child: FlatPrimaryButton(
                            info: 'Have an Account? ',
                            title: 'Login',
                            onTap: () {
                              Get.offAllNamed(Routes.LOGIN);
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
