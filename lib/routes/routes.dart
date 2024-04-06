import 'package:capstone_ptp/pages/main_pages/notification_page.dart';

import '../pages/intro_pages/login_page.dart';
import '../pages/main_pages/page_navigation.dart';

var appRoutes = {
  "/": (context) => LoginPage(),
  "/login": (context) => LoginPage(),
  "/home": (context) => PageNavigation(),
  "/notifications": (context) => NotificationPage(),
};
