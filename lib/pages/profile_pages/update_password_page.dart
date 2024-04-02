import 'package:flutter/material.dart';
import '../../services/firebase_authentication.dart';
import '../../services/local_variables.dart';
import '../../utils/global_message.dart';

class UpdatePasswordPage extends StatefulWidget {
  @override
  _UpdatePasswordPageState createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late GlobalMessage globalMessage;

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final FirebaseAuthentication _firebaseAuth = FirebaseAuthentication();

  bool _isObscureNewPassword = true;
  bool _isObscureConfirmPassword = true;

  String? _validateNewPassword(String? value) {
    if (value!.isEmpty) {
      return 'Vui lòng nhập mật khẩu mới.';
    } else if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự.';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value != _newPasswordController.text) {
      return 'Mật khẩu không khớp';
    }
    return null;
  }

  void _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _firebaseAuth.updatePassword(_newPasswordController.text);

        // Logout firebase
        await _firebaseAuth.signOut();
        // Clear local variable
        LocalVariables.authkeyGoogle = '';
        LocalVariables.displayName = '';
        LocalVariables.currentEmail = '';
        LocalVariables.photoURL = '';
        LocalVariables.uid = '';
        LocalVariables.jwtToken = '';
        LocalVariables.phoneNumber = '';
        LocalVariables.userGUID = '';

        // Clear cart
        // Redirect to the login page and clear the navigation stack
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/login',
          (Route<dynamic> route) => false,
        );
        globalMessage.showSuccessMessage(
            "Thay đổi mật khẩu thành công.\nVui lòng đăng nhập lại.");
      } catch (error) {
        globalMessage.showErrorMessage("Thay đổi mật khẩu thất bại.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    globalMessage = GlobalMessage(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Thay đổi mật khẩu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _newPasswordController,
                obscureText: _isObscureNewPassword,
                maxLength: 30,
                decoration: InputDecoration(
                  labelText: 'Nhập mật khẩu mới',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscureNewPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscureNewPassword = !_isObscureNewPassword;
                      });
                    },
                  ),
                ),
                validator: _validateNewPassword,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isObscureConfirmPassword,
                maxLength: 30,
                decoration: InputDecoration(
                  labelText: 'Nhập lại mật khẩu mới',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscureConfirmPassword = !_isObscureConfirmPassword;
                      });
                    },
                  ),
                ),
                validator: _validateConfirmPassword,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updatePassword,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFFFCCF59)),
                ),
                child: const Text(
                  'Đổi mật khẩu',
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
      ),
    );
  }
}
