import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/wallet_model.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../models/transaction_model.dart';
import '../../services/api_services/wallet_api.dart';
import '../activity_pages/transaction_history_tab.dart';

class WalletPage extends StatefulWidget {
  final String userId;

  WalletPage({required this.userId});

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  late Future<Wallet> _walletFuture;
  bool _hideAmount = false;

  String formatPrice(double price) {
    final format = NumberFormat("#,##0", "en_US");
    String formattedPrice = format.format(price);
    return formattedPrice.replaceAll(',', '.');
  }

  @override
  void initState() {
    super.initState();
    _walletFuture = WalletApi.fetchUserWallet(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCCF59),
        title: const Text(
          'Thông tin ví',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Wallet>(
        future: _walletFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Có lỗi xảy ra vui lòng thử lại: ${snapshot.error}');
          } else {
            final wallet = snapshot.data!;
            List<Transaction>? transactions = wallet.transactions;
            transactions
                .sort((a, b) => a.creationDate.compareTo(b.creationDate));
            transactions = transactions.reversed.toList();

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: 220,
                    child: Stack(children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Stack(children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.85,
                            height: 220,
                            child: SvgPicture.asset(
                              'lib/assets/images/container_wallet.svg',
                              alignment: Alignment.topCenter,
                              fit: BoxFit.contain,
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 30,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _hideAmount = !_hideAmount;
                                        });
                                      },
                                      icon: Icon(
                                        _hideAmount
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ),
                                    const Text(
                                      "Số dư hiện tại",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 50,
                            right: 30,
                            child: SizedBox(
                              width: 160,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      _hideAmount
                                          ? '*****'
                                          : formatPrice(
                                              wallet.amount.toDouble()),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                      softWrap: true,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  SvgPicture.asset(
                                    'lib/assets/icons/tabler_coin_icon.svg',
                                    alignment: Alignment.center,
                                    fit: BoxFit.contain,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ]),
                      ),
                      Positioned(
                        top: 60,
                        left: 0,
                        child: SizedBox(
                          width: 160,
                          height: 160,
                          child: SvgPicture.asset(
                            'lib/assets/images/money.svg',
                            alignment: Alignment.center,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 160,
                        right: 40,
                        child: Text(
                          "Nạp tiền >",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                      ),
                    ]),
                  ),

                  // list for history transaction
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lịch sử giao dịch",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.black,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                  if (transactions.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        return TransactionCard(
                            transaction: transactions![index]);
                      },
                    ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
