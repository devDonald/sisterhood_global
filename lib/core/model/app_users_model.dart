import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const USERID = "userId";
  static const NAME = "name";
  static const EMAIL = "email";
  static const COUNTRY = "country";
  static const PHOTO = "photo";
  static const PHONE = "phone";
  static const CODE = "code";
  static const TYPE = "type";
  static const DIALCODE = "dialCode";
  static const ISADMIN = "isAdmin";

  String? userId;
  String? name;
  String? country;
  String? photo;
  String? email;
  String? phone;
  String? code;
  String? type;
  String? dialCode;
  bool? isAdmin = false;

  UserModel(
      {this.userId,
      this.name,
      this.country,
      this.photo,
      this.email,
      this.phone,
      this.code,
      this.dialCode,
      this.type,
      this.isAdmin});

  toJson() {
    return {
      "userId": userId,
      "email": email,
      'name': name,
      'country': country,
      'photo': photo,
      'code': code,
      'isAdmin': isAdmin,
      'dialCode': dialCode,
      'phone': phone,
      'type': type,
    };
  }

  updateUser() {
    return {
      "email": email,
      'name': name,
      'country': country,
      'code': code,
      'dialCode': dialCode,
      'phone': phone,
    };
  }

  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    name = snapshot.data()![NAME];
    email = snapshot.data()![EMAIL];
    country = snapshot.data()![COUNTRY];
    photo = snapshot.data()![PHOTO];
    userId = snapshot.data()![USERID];
    phone = snapshot.data()![PHONE];
    code = snapshot.data()![CODE];
    dialCode = snapshot.data()![DIALCODE];
    type = snapshot.data()![TYPE];
    isAdmin = snapshot.data()![ISADMIN];
  }
}
