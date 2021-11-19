import 'package:flutter/material.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/themes/theme_colors.dart';
import 'package:sisterhood_global/core/themes/theme_text.dart';
import 'package:sisterhood_global/core/widgets/country_code_button.dart';
import 'package:sisterhood_global/core/widgets/primary_button.dart';

class EditProfile extends StatefulWidget {
  static const String id = 'EditProfile';
  EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();

  String _code = "NG",
      dateOfBirth = '',
      dialCode = '+124',
      _country = "Nigeria",
      error = "";

  void _fetchUserData() async {
    try {
      usersRef.doc(auth.currentUser!.uid).get().then((ds) {
        if (ds.exists) {
          setState(() {
            _name.text = ds.data()!['name'];
            _email.text = ds.data()!['email'];
            _phone.text = ds.data()!['phone'];
            _code = ds.data()!['code'];
            _country = ds.data()!['country'];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _fetchUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: JanguAskColors.whiteColor,
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: Colors.white,
        title: Text('Edit Profile',
            style: TextStyle(
              color: JanguAskColors.primaryGreyColor,
              fontSize: 18.0,
              fontWeight: JanguAskFontWeight.kBoldText,
            )),
        titleSpacing: -5.0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          margin: EdgeInsets.only(top: 15),
          width: double.infinity,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 50,
                    bottom: 50,
                  ),
                  padding: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.0, 2.5),
                        blurRadius: 5,
                        color: JanguAskColors.shadowColor,
                      ),
                    ],
                    color: JanguAskColors.whiteColor,
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 8,
                            right: 8,
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                keyboardType: TextInputType.name,
                                style: TextStyle(fontSize: 20),
                                controller: _name,
                                textCapitalization: TextCapitalization.words,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                style: TextStyle(fontSize: 20),
                                textCapitalization: TextCapitalization.none,
                                keyboardType: TextInputType.emailAddress,
                                controller: _email,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      flex: 1,
                                      child: CountryCodeButton(
                                        height: 60,
                                        onSelectCode: (String _dialCode,
                                            String flagUri, String country) {
                                          _dialCode = _dialCode;
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
                                                color:
                                                    JanguAskColors.shadowColor,
                                              )
                                            ],
                                          ),
                                          width: double.infinity,
                                          // width: double.infinity,
                                          // height: 40.0,
                                          child: TextFormField(
                                            textCapitalization:
                                                TextCapitalization.none,
                                            keyboardType: TextInputType.phone,
                                            controller: _phone,
                                            decoration: InputDecoration(
                                              labelText: 'Phone Number',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: PrimaryButton(
                                  color: JanguAskColors.primaryColor,
                                  roundedEdge: 5,
                                  blurRadius: 3,
                                  buttonTitle: 'Save',
                                  width: 73.5,
                                  height: 36.5,
                                  onTap: () async {
                                    if (validateProfileEdit(
                                        _email.text,
                                        _name.text,
                                        _country,
                                        dialCode,
                                        _code,
                                        _phone.text)) {
                                      await firebaseFirestore
                                          .collection('users')
                                          .doc(auth.currentUser!.uid)
                                          .update({
                                        'name': _name.text,
                                        'email': _email.text,
                                        'country': _country,
                                        'code': _code,
                                        'dialCode': dialCode,
                                        'phone': _phone.text
                                      }).then((value) {
                                        successToastMessage(
                                            msg:
                                                "Profile updated successfully");
                                        Navigator.of(context).pop();
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                error,
                                style: TextStyle(color: Colors.red),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
