import 'package:get/get.dart';
import 'package:sisterhood_global/features/authentication/pages/login_screen.dart';
import 'package:sisterhood_global/features/authentication/pages/register_screen.dart';
import 'package:sisterhood_global/features/authentication/pages/reset_password.dart';
import 'package:sisterhood_global/features/home/pages/home.dart';
import 'package:sisterhood_global/splash_screen.dart';

class AppRoutes {
  AppRoutes._(); //this is to prevent anyone from instantiating this object
  static final routes = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(name: '/loginin', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => RegisterScreen()),
    GetPage(name: '/home', page: () => HomeScreen()),
    //GetPage(name: '/settings', page: () => SettingsUI()),
    GetPage(name: '/reset-password', page: () => const ResetPassword()),
    //GetPage(name: '/update-profile', page: () => UpdateProfileUI()),
  ];
}
