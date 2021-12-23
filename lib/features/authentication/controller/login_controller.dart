import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sisterhood_global/core/constants/contants.dart';
import 'package:sisterhood_global/core/model/app_users_model.dart';
import 'package:sisterhood_global/core/widgets/customFullScreenDialog.dart';
import 'package:sisterhood_global/core/widgets/custom_dialog.dart';
import 'package:sisterhood_global/features/authentication/pages/login_screen.dart';
import 'package:sisterhood_global/features/home/pages/home.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User> firebaseUser;
  RxBool isLoggedIn = false.obs;
  late GoogleSignIn googleSign;
  late User _user;
  var isSignIn = false.obs;

  String usersCollection = "users";
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    googleSign = GoogleSignIn();
    firebaseUser = Rx<User>(auth.currentUser!);
    ever(isSignIn, handleAuthStateChanged);
    isSignIn.value = auth.currentUser != null;
    auth.authStateChanges().listen((event) {
      isSignIn.value = event != null;
    });
  }

  void handleAuthStateChanged(isLoggedIn) {
    if (isLoggedIn) {
      userModel.bindStream(listenToUser());
      Get.offAll(() => HomeScreen());
    } else {
      Get.offAll(() => LoginScreen());
    }
  }

  void signIn(String email, String password) async {
    try {
      CustomFullScreenDialog.showDialog();
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((result) {
        successToastMessage(msg: 'Login Successful');
        CustomFullScreenDialog.cancelDialog();
        Get.offAll(() => HomeScreen());
      }).onError((error, stackTrace) {
        CustomFullScreenDialog.cancelDialog();
        errorToastMessage(msg: error.toString());
      });
    } catch (e) {
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signUp(String email, String password, UserModel user) async {
    CustomFullScreenDialog.showDialog();
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((result) {
        user.userId = result.user!.uid;
        _addUserToFirestore(user);
        successToastMessage(msg: 'Registration Successful');
        CustomFullScreenDialog.cancelDialog();
        Get.offAll(() => HomeScreen());
      }).onError((error, stackTrace) {
        CustomFullScreenDialog.cancelDialog();
        errorToastMessage(msg: error.toString());
      });
    } catch (e) {
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  void signOut() async {
    googleSign.signOut();
    auth.signOut();
  }

  _addUserToFirestore(UserModel user) {
    firebaseFirestore
        .collection(usersCollection)
        .doc(user.userId)
        .set(user.toJson());
    _user.updatePhotoURL(user.photo);
    _user.updateDisplayName(user.name);
  }

  void googleLogin() async {
    CustomFullScreenDialog.showDialog();
    GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();
    if (googleSignInAccount == null) {
      CustomFullScreenDialog.cancelDialog();
    } else {
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      OAuthCredential oAuthCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      await auth.signInWithCredential(oAuthCredential).then((result) async {
        await firebaseFirestore
            .collection(usersCollection)
            .doc(result.user!.uid)
            .get()
            .then((value) async {
          if (!value.exists) {
            UserModel model = UserModel(
                userId: result.user!.uid,
                name: result.user!.displayName,
                country: 'Nigeria',
                code: 'NG',
                dialCode: '+124',
                isAdmin: false,
                phone: result.user!.phoneNumber,
                photo: result.user!.photoURL,
                email: result.user!.email,
                type: 'USER');
            _addUserToFirestore(model);
          }
        });
        successToastMessage(msg: 'Login Successful');
        CustomFullScreenDialog.cancelDialog();
        Get.offAll(() => HomeScreen());
      }).onError((error, stackTrace) {
        errorToastMessage(msg: error.toString());
      });
    }
  }

  updateUserData(Map<String, dynamic> data) {
    firebaseFirestore
        .collection(usersCollection)
        .doc(firebaseUser.value.uid)
        .update(data);
  }

  Stream<UserModel> listenToUser() => firebaseFirestore
      .collection(usersCollection)
      .doc(firebaseUser.value.uid)
      .snapshots()
      .map((snapshot) => UserModel.fromSnapshot(snapshot));

  void resetPassword(String email, BuildContext context) async {
    await auth.sendPasswordResetEmail(email: email).then((_) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDescriptionBox(
              title: 'Password Reset Link Generated',
              descriptions:
                  'Check your email $email for the link to reset your password',
            );
          });
    }).catchError((error) {});
  }
}
