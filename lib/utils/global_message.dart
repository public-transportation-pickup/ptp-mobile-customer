import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

class GlobalMessage {
  final BuildContext context;

  GlobalMessage(this.context);

  void showSuccessMessage(String inputMessage) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: inputMessage,
    );
  }

  void showErrorMessage(String inputMessage) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      text: inputMessage,
    );
  }

  void showWarnMessage(String inputMessage) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.warning,
      text: inputMessage,
    );
  }

  void showConfirmMessage(String inputMessage) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      text: inputMessage,
      confirmBtnText: 'Yes',
      cancelBtnText: 'No',
      confirmBtnColor: Colors.green,
    );
  }

  void showLoading() {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.loading,
      title: 'Loading',
      text: 'Please wait for a while!',
    );
  }
}
