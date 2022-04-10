import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/widgets/custom_dialog.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({
    Key? key,
  }) : super(key: key);
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
          backgroundColor: ThemeColors.whiteColor,
          title: Text(
            'Password Reset',
            style: Theme.of(context).textTheme.headline5,
          ),
          iconTheme:
              const IconThemeData(color: ThemeColors.blackColor1, size: 35)),
      body: ListView(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          Container(
            padding: const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                const Text(
                  'Enter the email address associated with your account to reset your password',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
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
                    controller: _email,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    textInputAction: TextInputAction.newline,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Email',
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                SizedBox(
                  height: 40.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.black54,
                    color: Colors.black,
                    elevation: 7.0,
                    child: GestureDetector(
                        onTap: () async {
                          if (validateEmail(_email.text)) {
                            await auth
                                .sendPasswordResetEmail(email: _email.text)
                                .then((_) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDescriptionBox(
                                      title: 'Password Reset Link Generated',
                                      descriptions:
                                          'Check your email ${_email.text} for the link to reset your password',
                                    );
                                  });
                            }).catchError((error) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return CustomDescriptionBox(
                                      title: 'Password Reset Error',
                                      descriptions: error.toString(),
                                    );
                                  });
                            });
                          }
                        },
                        child: const Center(
                            child: Text(
                          'RESET PASSWORD',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ))),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
        ],
      ),
    );
  }
}
