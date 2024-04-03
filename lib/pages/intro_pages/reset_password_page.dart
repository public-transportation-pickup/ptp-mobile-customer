import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../services/firebase_authentication.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuthentication _auth = FirebaseAuthentication();

  String _resetPasswordMessage = '';
  bool isLoading = false;
  int requestCount = 0;
  Timer? cooldownTimer;
  late DateTime lastRequestTime;

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

  Future<void> _resetPassword() async {
    final now = DateTime.now();
    final difference = now.difference(lastRequestTime);
    if (difference.inSeconds < 60 && requestCount >= 3) {
      _showResetLimitMessage(difference);
      return;
    }
    _showLoading();
    String email = _emailController.text.trim();

    if (email.isNotEmpty) {
      try {
        await _auth.resetPassword(email);
        setState(() {
          _resetPasswordMessage =
              'Email xác thực đã được gửi.\nVui lòng kiểm tra hòm thư Email để tiến hành khôi phục mật khẩu.';
          requestCount++;
          lastRequestTime = DateTime.now();
          if (requestCount == 3) {
            cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
              setState(() {
                final remainingTime = 60 - timer.tick;
                if (remainingTime <= 0) {
                  timer.cancel();
                  requestCount = 0;
                  cooldownTimer = null; // Reset cooldown timer
                  _resetPasswordMessage = '';
                } else {
                  _resetPasswordMessage =
                      'Bạn đã vượt quá số lần yêu cầu.\nVui lòng thử lại sau $remainingTime giây.';
                }
              });
            });
          }
        });
      } catch (error) {
        setState(() {
          _resetPasswordMessage = 'Email không hợp lệ!';
        });
      } finally {
        _hideLoading();
      }
    } else {
      _hideLoading();
      setState(() {
        _resetPasswordMessage = 'Vui lòng nhập email.';
      });
    }
  }

  void _showResetLimitMessage(Duration difference) {
    final remainingTime = 60 - difference.inSeconds;
    setState(() {
      if (remainingTime == 0 || remainingTime <= 1) {
        _resetPasswordMessage = '';
      } else {
        _resetPasswordMessage =
            'Bạn đã vượt quá số lần yêu cầu.\nVui lòng thử lại sau $remainingTime giây.';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    lastRequestTime = DateTime.now();
  }

  @override
  void dispose() {
    cooldownTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Image.asset(
                    'lib/assets/images/bus_logo.png',
                    width: 150,
                    height: 150,
                  ),
                  const Text(
                    "Khôi phục mật khẩu!",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(56),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nhập email của bạn',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 100,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _resetPassword,
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFFFCCF59)),
                      ),
                      child: const Text(
                        'Tiếp tục',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    _resetPasswordMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
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
      ]),
    );
  }
}
