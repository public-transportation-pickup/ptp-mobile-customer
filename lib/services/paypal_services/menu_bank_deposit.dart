import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/global_message.dart';
import '../api_services/wallet_api.dart';
import 'paypal_checkout_service.dart';

class MenuBankDeposit extends StatefulWidget {
  final Function(bool) onDepositSuccess;

  MenuBankDeposit({Key? key, required this.onDepositSuccess}) : super(key: key);

  @override
  _MenuBankDepositState createState() => _MenuBankDepositState();
}

class _MenuBankDepositState extends State<MenuBankDeposit> {
  late String selectedOption;

  // Function to initiate PayPal checkout and handle the payment result
  Future<void> initiatePaypalCheckoutForTicket(
    String orderName,
    int amount,
    BuildContext context,
  ) async {
    bool isSuccess = await PaypalCheckoutService.initiatePaypalCheckout(
      context,
      orderName: orderName,
      amount: amount,
    );

    if (isSuccess) {
      bool result = await WalletApi.depositMoney(amount * 23000);
      if (result) {
// ignore: use_build_context_synchronously
        GlobalMessage(context).showSuccessMessage("Nạp tiền thành công!");
        // Call the callback function to indicate success
        widget.onDepositSuccess(true);
      } else {
// ignore: use_build_context_synchronously
        GlobalMessage(context).showErrorMessage("Nạp tiền thất bại!");
      }
    } else {
      // ignore: use_build_context_synchronously
      GlobalMessage(context).showErrorMessage("Nạp tiền thất bại!");
    }
  }

  @override
  void initState() {
    super.initState();
    selectedOption = '';
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn phương thức thanh toán'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RadioListTile(
              title: const Text('PayPal'),
              value: 'PayPal',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value.toString();
                });
              },
              selected: selectedOption == 'PayPal',
            ),
            RadioListTile(
              title: const Text('Mastercard'),
              value: 'Mastercard',
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value.toString();
                });
              },
              selected: selectedOption == 'Mastercard',
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                if (selectedOption.isEmpty) {
                  GlobalMessage(context)
                      .showWarnMessage("Vui lòng chọn phương thức thanh toán.");
                } else {
                  if (selectedOption == 'PayPal') {
                    HapticFeedback.mediumImpact();
                    await initiatePaypalCheckoutForTicket(
                        "Deposit to your wallet", 5, context);
                  } else {
                    GlobalMessage(context)
                        .showWarnMessage("Phương thức thanh toán chưa hỗ trợ.");
                  }
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: const Text('Tiếp tục'),
            ),
          ],
        ),
      ),
    );
  }
}
