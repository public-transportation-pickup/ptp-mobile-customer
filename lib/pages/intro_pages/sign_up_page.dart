import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../services/firebase_authentication.dart';
import '../../utils/global_message.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isObscure = true;
  bool isLoading = false;

  late GlobalMessage globalMessage;

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

  void _createAccount() async {
    _showLoading();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        // Call the function to create account with email and password
        await FirebaseAuthentication()
            .createAccountWithEmailAndPassword(email, password);

        // Optionally, you can navigate to another screen after successful signup
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

        // Clear text fields after successful signup
        _emailController.clear();
        _passwordController.clear();

        // Show a success message or navigate to another screen
        globalMessage.showSuccessMessage(
            "Tạo tài khoản thành công.\nVui lòng kiểm tra email của bạn để xác thực tài khoản.");
      } catch (error) {
        if (error is String) {
          globalMessage.showErrorMessage(error);
        } else {
          globalMessage.showErrorMessage("Tạo tài khoản thất bại:\n$error");
        }
      } finally {
        _hideLoading();
      }
    } else {
      _hideLoading();
      // Show an error message if email or password is empty
      globalMessage.showWarnMessage("Vui lòng nhập email và password.");
    }
  }

  @override
  Widget build(BuildContext context) {
    globalMessage = GlobalMessage(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCCF59),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    'lib/assets/images/sign_up.png',
                    width: 120,
                    height: 120,
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    "Đăng ký tài khoản",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Card(
                          color: const Color(0xFFFCCF59),
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  height: 50,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(56),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: TextField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Email',
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  height: 50,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(56),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: TextField(
                                      controller: _passwordController,
                                      obscureText: _isObscure,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        suffixIcon: IconButton(
                                          icon: Icon(_isObscure
                                              ? Icons.visibility_off
                                              : Icons.visibility),
                                          onPressed: () {
                                            setState(() {
                                              _isObscure = !_isObscure;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: _createAccount,
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFFFCCF59)),
                          ),
                          child: const Text(
                            'Đăng ký',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isLoading)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
