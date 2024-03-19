import 'dart:convert';

import 'package:capstone_ptp/models/wallet_model.dart';
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
}
