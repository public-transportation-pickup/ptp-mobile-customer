import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:logger/logger.dart';
import '../../services/firebase_authentication.dart';
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

  @override
  Widget build(BuildContext context) {
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
                          const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 32),
                            child: Row(
                              children: [
                                Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                    color: Color(0xFF353434),
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '|',
                                  style: TextStyle(
                                    color: Color(0xFF353434),
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                    color: Color(0xFFB1B1B1),
                                    fontSize: 20,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
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
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: TextField(
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Tên đăng nhập',
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
                          const SizedBox(
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
                          const SizedBox(height: 8),
                          Container(
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
                                _showLoading(); // Show loading animation

                                User? user =
                                    await _firebaseAuth.signInWithGoogle();

                                _hideLoading(); // Hide loading animation

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
                                } else {
                                  // Show error dialog
                                  // ignore: use_build_context_synchronously
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Có lỗi xảy ra!',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: const Text(
                                            'Đăng nhập với Google thất bại.\nVui lòng thử lại.'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
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
