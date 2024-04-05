import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
  late TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    selectedOption = '';
    amountController = TextEditingController();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  double formatVNDtoUSD(int amountInVND) {
    // Assuming the exchange rate is 1 USD = 23000 VND
    double exchangeRate = 23000;
    // Convert VND to USD
    double amountInUSD = amountInVND / exchangeRate;
    // Round the amount to two decimal places
    double roundedAmount = double.parse(amountInUSD.toStringAsFixed(2));
    // Return the rounded amount in USD
    return roundedAmount;
  }

  String formatCurrency(String amount) {
    final currencyFormat = NumberFormat("#,##0", "vi_VN");
    final intValue =
        int.tryParse(amount.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
    return currencyFormat.format(intValue);
  }

  Future<void> initiatePaypalCheckoutForTicket(
    String orderName,
    int amountVND,
    double amount,
    BuildContext context,
  ) async {
    bool isSuccess = await PaypalCheckoutService.initiatePaypalCheckout(
      context,
      orderName: orderName,
      amount: amount,
    );

    if (isSuccess) {
      bool result = await WalletApi.depositMoney(amountVND);
      if (result) {
        GlobalMessage(context).showSuccessMessage("Nạp tiền thành công!");
        // Call the callback function to indicate success
        widget.onDepositSuccess(true);
      } else {
        GlobalMessage(context).showErrorMessage("Nạp tiền thất bại!");
      }
    } else {
      GlobalMessage(context).showErrorMessage("Nạp tiền thất bại!");
    }
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
            Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 4, 4),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(9),
                  ],
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Nhập số tiền (VND)',
                    hintStyle: TextStyle(fontSize: 20),
                  ),
                  style: const TextStyle(fontSize: 20),
                  onChanged: (value) {
                    final formattedAmount = formatCurrency(value);
                    setState(() {
                      amountController.text = formattedAmount;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                if (selectedOption.isEmpty) {
                  GlobalMessage(context)
                      .showWarnMessage("Vui lòng chọn phương thức thanh toán.");
                } else {
                  final amountText =
                      amountController.text.replaceAll(RegExp(r'[^0-9]'), '');
                  if (amountText.isEmpty) {
                    GlobalMessage(context)
                        .showWarnMessage("Vui lòng nhập số tiền.");
                  } else {
                    final amount = int.tryParse(amountText);
                    if (amount == null ||
                        amount < 50000 ||
                        amount > 100000000) {
                      GlobalMessage(context).showWarnMessage(
                          "Số tiền cần nạp phải từ\n50,000 VND đến 100,000,000 VND");
                    } else {
                      if (selectedOption == 'PayPal') {
                        HapticFeedback.mediumImpact();
                        await initiatePaypalCheckoutForTicket(
                            "Nạp tiền vào ví của bạn",
                            amount,
                            formatVNDtoUSD(amount),
                            context);
                      } else {
                        GlobalMessage(context).showWarnMessage(
                            "Phương thức thanh toán chưa được hỗ trợ.");
                      }
                    }
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
