import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'routes/routes.dart';
import './themes/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: customLightTheme,
      darkTheme: customDarkTheme,
      initialRoute: "/",
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}
