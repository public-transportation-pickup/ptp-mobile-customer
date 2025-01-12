import 'package:capstone_ptp/pages/intro_pages/reset_password_page.dart';
import 'package:capstone_ptp/pages/intro_pages/sign_up_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import 'package:open_settings/open_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../services/firebase_authentication.dart';
import '../../utils/global_message.dart';
import '../main_pages/page_navigation.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // CHECK LOG
  var checkLog = Logger(printer: PrettyPrinter());

  bool _isPasswordVisible = false;
  bool isLoading = false;

  final FirebaseAuthentication _firebaseAuth = FirebaseAuthentication();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late GlobalMessage globalMessage;

  void _loginWithEmailAndPass() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        _showLoading();
        // Call the function to login account with email and password
        User? user =
            await _firebaseAuth.signInWithEmailAndPassword(email, password);
        _hideLoading();

        if (user != null) {
          // Successfully signed in with Google
          checkLog.d(user.providerData);
          // Redirect to the Home Page
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PageNavigation(),
            ),
          );
        }
      } catch (error) {
        _hideLoading();
        if (error is String) {
          globalMessage.showErrorMessage(error);
        } else {
          globalMessage.showErrorMessage("Something wrong:\n$error");
        }
      }
    } else {
      // Show an error message if email or password is empty
      globalMessage.showWarnMessage("Vui lòng nhập email và password.");
    }
  }

  void _loginWithGoogle() async {
    try {
      _showLoading();
      // Call the function to login account with email and password
      User? user = await _firebaseAuth.signInWithGoogle();
      _hideLoading();

      if (user != null) {
        // Successfully signed in with Google
        checkLog.d(user.providerData);
        // Redirect to the Home Page
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => PageNavigation(),
          ),
        );
      }
    } catch (error) {
      _hideLoading();
      if (error is String) {
        globalMessage.showErrorMessage(error);
      } else {
        globalMessage.showErrorMessage("Something wrong:\n$error");
      }
    }
  }

  void _showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void _hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.mediaLibrary,
      Permission.notification,
    ].request();
    checkLog.d('Check permission:  $statuses');
    // Check if permissions are granted
    if (statuses[Permission.location] == PermissionStatus.granted &&
        statuses[Permission.storage] == PermissionStatus.granted &&
        statuses[Permission.notification] == PermissionStatus.granted &&
        statuses[Permission.mediaLibrary] == PermissionStatus.granted) {
    } else {
      // Handle the case when permissions are not granted
      OpenSettings.openAppSetting();
    }
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    globalMessage = GlobalMessage(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.00, -1.00),
                  end: Alignment(0, 1),
                  colors: [Colors.white, Color(0xFFFCCF59)],
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                  Center(
                    child: Container(
                      width: 340,
                      height: MediaQuery.of(context).size.height,
                      decoration: const ShapeDecoration(
                        color: Color(0xFFFCCF59),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(32),
                            topRight: Radius.circular(32),
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 32),
                            child: Row(
                              children: [
                                const Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    color: Color(0xFF353434),
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  '|',
                                  style: TextStyle(
                                    color: Color(0xFF353434),
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SignUpPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Đăng ký',
                                    style: TextStyle(
                                      color: Color(0xFFB1B1B1),
                                      fontSize: 20,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      height: 0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 292,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(56),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                controller: _emailController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Email',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 292,
                            height: 50,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(56),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                controller: _passwordController,
                                obscureText: !_isPasswordVisible,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Password',
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isPasswordVisible =
                                            !_isPasswordVisible;
                                      });
                                    },
                                    child: Icon(
                                      _isPasswordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            onTap: () {
                              HapticFeedback.lightImpact();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResetPasswordPage(),
                                ),
                              );
                            },
                            child: const SizedBox(
                              width: 280,
                              height: 23,
                              child: Text(
                                'Quên mật khẩu?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          InkWell(
                            onTap: () async {
                              HapticFeedback.lightImpact();
                              _loginWithEmailAndPass();
                            },
                            child: Container(
                              width: 133,
                              height: 45,
                              decoration: ShapeDecoration(
                                color: const Color(0xFFFBAB40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(56),
                                ),
                              ),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Đăng nhập',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFFFFEFC8),
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 292,
                            height: 45,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(56),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                HapticFeedback.lightImpact();
                                _loginWithGoogle();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'lib/assets/icons/Google__G__logo.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'Login with Google',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: LoadingAnimationWidget.discreteCircle(
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
