import 'package:get/get.dart';
import 'package:sisterhood_global/core/widgets/menu_drawer.dart';
import 'package:sisterhood_global/features/authentication/binding/auth_binding.dart';
import 'package:sisterhood_global/features/authentication/pages/login_screen.dart';
import 'package:sisterhood_global/features/authentication/pages/register_screen.dart';
import 'package:sisterhood_global/features/home/binding/drawer_binding.dart';
import 'package:sisterhood_global/splash_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
      binding: AuthBinding(),
    ),

    GetPage(
      name: _Paths.DRAWER,
      page: () => MenuDrawer(),
      binding: DrawerBinding(),
    ),
    // GetPage(
    //   name: _Paths.WELCOME,
    //   page: () => WelcomeView(),
    //   binding: WelcomeBinding(),
    // ),
  ];
}
