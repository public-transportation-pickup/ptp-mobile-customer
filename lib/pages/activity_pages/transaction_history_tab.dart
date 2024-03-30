import 'package:capstone_ptp/models/wallet_model.dart';
import 'package:capstone_ptp/services/api_services/wallet_api.dart';
import 'package:capstone_ptp/services/local_variables.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../../models/transaction_model.dart';

class TransactionHistoryTab extends StatefulWidget {
  @override
  _TransactionHistoryTabState createState() => _TransactionHistoryTabState();
}

class _TransactionHistoryTabState extends State<TransactionHistoryTab> {
  //CHECK LOG
  var checkLog = Logger(printer: PrettyPrinter());
  late Future<List<Transaction>> _futureTransactions;

  @override
  void initState() {
    super.initState();
    _futureTransactions = _fetchTransactions();
  }

  Future<List<Transaction>> _fetchTransactions() async {
    final String userId = LocalVariables.userGUID!;
    try {
      Wallet userWallet = await WalletApi.fetchUserWallet(userId);
      List<Transaction> listTransactions = userWallet.transactions;
      return listTransactions;
    } catch (error) {
      checkLog.e('Error fetching transaction: $error');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Transaction>>(
      future: _futureTransactions,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Transaction>? transactions = snapshot.data;
          if (transactions != null && transactions.isNotEmpty) {
            // Sort transactions by creation date in descending order
            transactions
                .sort((a, b) => b.creationDate.compareTo(a.creationDate));
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                if (transactions[index].transactionType == 'Transfer') {
                  return TransactionCard(transaction: transactions[index]);
                } else {
                  return const SizedBox
                      .shrink(); // Return an empty SizedBox if not a transfer
                }
              },
            );
          } else {
            return const Center(child: Text('Không có lịch sử thanh toán.'));
          }
        }
      },
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  TransactionCard({required this.transaction});

  String formatPrice(double price) {
    final format = NumberFormat("#,##0", "en_US");
    String formattedPrice = format.format(price);
    return formattedPrice.replaceAll(',', '.');
  }

  String formatDate(String date) {
    DateTime creationDate = DateTime.parse(date);
    String formattedDate =
        DateFormat('HH:mm - dd/MM/yyyy').format(creationDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.attach_money,
                size: 36,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (transaction.transactionType == "Transfer")
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Thanh toán đơn hàng",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Hình thức: Thanh toán ví',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  if (transaction.transactionType == "Receive")
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hoàn tiền hủy đơn",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Hình thức: Hoàn tiền',
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  Text(formatDate(transaction.creationDate)),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomRight,
                child: transaction.transactionType == "Receive"
                    ? Text(
                        "+ ${formatPrice(transaction.amount.toDouble())}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : transaction.transactionType == "Transfer"
                        ? Text(
                            "- ${formatPrice(transaction.amount.toDouble())}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : const SizedBox(), // If none of the conditions are met, render an empty SizedBox
              ),
            ),
          ],
        ),
      ),
    );
  }
}
