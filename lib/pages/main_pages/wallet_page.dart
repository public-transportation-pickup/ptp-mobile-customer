import 'package:flutter/material.dart';
import 'package:capstone_ptp/models/wallet_model.dart';
import 'package:intl/intl.dart';

import '../../services/api_services/wallet_api.dart';

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
      body: Center(
        child: FutureBuilder<Wallet>(
          future: _walletFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Có lỗi xảy ra vui lòng thử lại: ${snapshot.error}');
            } else {
              final wallet = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 220,
                        height: 220,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFFCCF59),
                            width: 10.0,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Số dư hiện tại (VND):',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _hideAmount
                                  ? '***'
                                  : formatPrice(wallet.amount.toDouble()),
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        child: IconButton(
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
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEEBBB),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(Icons.credit_card),
                            ),
                          ),
                          const Text('Nạp tiền'),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Container(
                              height: 48,
                              width: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEEBBB),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Icon(Icons.add_link_outlined),
                            ),
                          ),
                          const Text('Liên kết ngân hàng'),
                        ],
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
