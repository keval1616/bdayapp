import 'package:bdayapp/screen/addBday_screen.dart';
import 'package:bdayapp/screen/home_screen.dart';
import 'package:get/get.dart';

class MyRoutes {
  static const String home = "/";
  static const String addBday = "/addBday";
  static const Duration duration = Duration(milliseconds: 400);

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: () => HomeScreen(),
      transitionDuration: duration,
    ),
    GetPage(
      name: addBday,
      page: () => const AddBdayScreen(),
      transitionDuration: duration,
    ),
  ];
}
