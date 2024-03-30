import 'package:flutter/material.dart';
import '../../models/transaction_model.dart';
import 'transaction_history_tab.dart';

class FullTransactionsPage extends StatelessWidget {
  final List<Transaction>? transactions;

  FullTransactionsPage({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Toàn bộ giao dịch',
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
      body: SingleChildScrollView(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: transactions!.length,
          itemBuilder: (context, index) {
            return TransactionCard(transaction: transactions![index]);
          },
        ),
      ),
    );
  }
}
