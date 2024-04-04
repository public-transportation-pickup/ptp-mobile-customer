import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_checkout/flutter_paypal_checkout.dart';

class PaypalCheckoutService {
  static Future<bool> initiatePaypalCheckout(
    BuildContext context, {
    required String orderName,
    required int amount,
  }) async {
    Completer<bool> completer = Completer<bool>();

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalCheckout(
          sandboxMode: true,
          clientId:
              "AayHcscHm9UCh2bVK3DQ2qxEgjBJPoYumEV_LsHb1ZrrcGfKrBCBja0L1XzttPC0DcD52_n08PQZKIPt",
          secretKey:
              "EAkNIpiHufzrV8qP1X0NcpXAsE3P24Gm7OhPJKWk0IEI2F-mRwlK1pgFNXVWDwZL9tR6TSRSwKna1uKg",
          returnURL: "success.snippetcoder.com",
          cancelURL: "cancel.snippetcoder.com",
          transactions: [
            {
              "amount": {
                "total": (amount).toString(),
                "currency": "USD",
                "details": {
                  "subtotal": (amount).toString(),
                  "shipping": '0',
                  "shipping_discount": 0,
                }
              },
              "description": "Payment for $orderName"
            }
          ],
          note: "Contact us for any questions.",
          onSuccess: (Map params) async {
            print("onSuccess: $params");
            completer.complete(true); // Resolve the completer with success
          },
          onError: (error) {
            print("onError: $error");
            completer.complete(false); // Resolve the completer with failure
            Navigator.pop(context);
          },
          onCancel: () {
            print('cancelled:');
            completer.complete(false); // Resolve the completer with failure
          },
        ),
      ),
    );

    return completer.future; // Return the future to await the result
  }
}
