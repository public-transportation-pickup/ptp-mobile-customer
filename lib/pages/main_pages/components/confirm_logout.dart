import 'package:flutter/material.dart';

class ConfirmLogoutDialog {
  static Future<bool> show(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Xác nhận đăng xuất',
            style: TextStyle(color: Colors.red),
          ),
          content: const Text('Bạn có chắc muốn đăng xuất?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // User does not want to logout
                Navigator.of(context).pop(false);
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                // User confirms logout
                Navigator.of(context).pop(true);
              },
              child: const Text('Có'),
            ),
          ],
        );
      },
    );
  }
}
