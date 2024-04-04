import 'dart:convert';

import 'package:capstone_ptp/models/wallet_model.dart';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:http/http.dart' as http;
import 'package:capstone_ptp/services/api_services/api_services.dart';

class WalletApi extends ApiService {
  //GET USER WALLET BY USER ID
  static Future<Wallet> fetchUserWallet(String userId) async {
    final Uri userUrl =
        Uri.parse('${ApiService.baseUrl}/users/$userId/wallets');
    try {
      final response = await http.get(
        userUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        //checkLog.t(jsonResponse);
        return Wallet.fromJson(jsonResponse);
      } else {
        ApiService.checkLog
            .e('Failed to load user wallet: ${response.statusCode}');
        throw Exception('Failed to load user wallet: ${response.statusCode}');
      }
    } catch (e) {
      ApiService.checkLog.e('Error while fetching user wallet: $e');
      throw Exception('Error while fetching user wallet: $e');
    }
  }

  // Function to deposit money into wallet
  static Future<bool> depositMoney(int amount) async {
    final Uri depositUrl = Uri.parse('${ApiService.baseUrl}/wallets');

    // Prepare the request body
    Map<String, dynamic> requestBody = {
      "amount": amount,
      "source": "Paypal",
      "type": "Deposit"
    };

    try {
      final response = await http.post(
        depositUrl,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${LocalVariables.jwtToken}',
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        // Deposit successful
        print("Nạp tiền thành công!");
        return true;
      } else {
        // Deposit failed
        print("Nạp tiền thất bại!");
        return false;
      }
    } catch (e) {
      // Error handling
      ApiService.checkLog.e('Error while depositing money: $e');
      throw Exception('Error while depositing money: $e');
    }
  }
}
