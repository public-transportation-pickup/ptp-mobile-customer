import 'package:capstone_ptp/pages/product_pages/cart_provider.dart';
import 'package:capstone_ptp/utils/noti_count.dart';
import 'package:capstone_ptp/utils/order_count.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'routes/routes.dart';
import './themes/theme.dart';
import 'services/firebase_message.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessageService().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => NotificationCountNotifier()),
        ChangeNotifierProvider(create: (_) => OrderCountNotifier()),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        theme: customLightTheme,
        darkTheme: customDarkTheme,
        initialRoute: "/",
        routes: appRoutes,
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
      ),
    );
  }
}
