import 'package:capstone_ptp/pages/activity_pages/full_transactions_page.dart';
import 'package:capstone_ptp/pages/product_pages/cart_page.dart';
import 'package:capstone_ptp/pages/profile_pages/update_password_page.dart';
import 'package:capstone_ptp/pages/profile_pages/update_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:logger/logger.dart';

import '../../../models/transaction_model.dart';
import '../../../models/wallet_model.dart';
import '../../../services/api_services/wallet_api.dart';
import '../../../services/local_variables.dart';
import '../activity_page.dart';

class GroupedListOption extends StatefulWidget {
  GroupedListOption({Key? key}) : super(key: key);
  @override
  _GroupedListOptionState createState() => _GroupedListOptionState();
}

class _GroupedListOptionState extends State<GroupedListOption> {
  var checkLog = Logger(printer: PrettyPrinter());
  late Future<List<Transaction>> _futureTransactions;

  Future<List<Transaction>> _fetchTransactions() async {
    final String userId = LocalVariables.userGUID!;
    try {
      Wallet userWallet = await WalletApi.fetchUserWallet(userId);
      List<Transaction> listTransactions = userWallet.transactions;

      // Sort transactions by creation date in descending order
      listTransactions.sort((a, b) => b.creationDate.compareTo(a.creationDate));

      return listTransactions;
    } catch (error) {
      checkLog.e('Error fetching transaction: $error');
      rethrow;
    }
  }

  final List<Map<String, dynamic>> elements = [
    {
      'name': 'Cập nhật thông tin cá nhân',
      'group': 'Tài khoản của tôi',
      'page': UpdateProfilePage()
    },
    {
      'name': 'Thay đổi mật khẩu',
      'group': 'Tài khoản của tôi',
      'page': UpdatePasswordPage()
    },
    {
      'name': 'Giỏ hàng của tôi',
      'group': 'Tài khoản của tôi',
      'page': CartPage()
    },
    {
      'name': 'Lịch sử giao dịch',
      'group': 'Tài khoản của tôi',
      'fetchTransactions': true,
    },
    {
      'name': 'Thông tin ứng dụng',
      'group': 'Trung tâm trợ giúp',
      'page': ActivityPage()
    },
  ];

  @override
  void initState() {
    super.initState();
    _futureTransactions = _fetchTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GroupedListView<dynamic, String>(
        elements: elements,
        groupBy: (element) => element['group'],
        groupComparator: (value1, value2) => value2.compareTo(value1),
        groupSeparatorBuilder: (String value) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        itemBuilder: (c, element) {
          return Card(
            surfaceTintColor: Colors.white,
            elevation: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
            child: GestureDetector(
              onTap: () {
                if (element['fetchTransactions'] != null &&
                    element['fetchTransactions']) {
                  // Fetch transactions and navigate to FullTransactionsPage
                  _futureTransactions.then((transactions) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            FullTransactionsPage(transactions: transactions),
                      ),
                    );
                  }).catchError((error) {
                    // Handle error
                    checkLog.e('Error fetching transactions: $error');
                  });
                } else {
                  // Navigate to the specified page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => element['page'],
                    ),
                  );
                }
              },
              child: SizedBox(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 2.0),
                  title: Text(element['name']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
