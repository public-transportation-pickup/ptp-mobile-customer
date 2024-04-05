import 'package:capstone_ptp/services/local_variables.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../models/transaction_model.dart';
import '../../models/wallet_log_model.dart';
import '../../models/wallet_model.dart';
import '../../services/api_services/wallet_api.dart';

class SpendingStatisticsPage extends StatefulWidget {
  @override
  _SpendingStatisticsPageState createState() => _SpendingStatisticsPageState();
}

class _SpendingStatisticsPageState extends State<SpendingStatisticsPage> {
  Future<Wallet>? walletFuture;
  String selectedTimePeriod = 'Week'; // Default to Week

  @override
  void initState() {
    super.initState();
    walletFuture = WalletApi.fetchUserWallet(LocalVariables.userGUID!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê chi tiêu'),
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Hiển thị theo: '),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: DropdownButton<String>(
                    value: selectedTimePeriod,
                    onChanged: (newValue) {
                      setState(() {
                        selectedTimePeriod = newValue!;
                      });
                    },
                    items: <String>['Week', 'Month']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: value == 'Week' ? Text('Tuần') : Text('Tháng'),
                      );
                    }).toList(),
                    icon: const Icon(Icons.arrow_drop_down),
                    iconSize: 30,
                    dropdownColor: Colors.white,
                    underline: const SizedBox(),
                  ),
                )
              ],
            ),
            Expanded(
              child: FutureBuilder<Wallet>(
                future: walletFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    Wallet wallet = snapshot.data!;

                    return SfCartesianChart(
                      primaryXAxis: const CategoryAxis(),
                      title: const ChartTitle(text: 'Tổng quan chi tiêu'),
                      legend: const Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        ColumnSeries<TransactionData, String>(
                          dataSource: calculateTransactionData(
                              wallet.transactions, selectedTimePeriod),
                          xValueMapper: (TransactionData data, _) =>
                              data.timePeriod,
                          yValueMapper: (TransactionData data, _) =>
                              data.amount,
                          name: 'Tiền chi tiêu',
                        ),
                        ColumnSeries<WalletLogData, String>(
                          dataSource: calculateWalletLogData(
                              wallet.walletLogs, selectedTimePeriod),
                          xValueMapper: (WalletLogData data, _) =>
                              data.timePeriod,
                          yValueMapper: (WalletLogData data, _) => data.amount,
                          name: 'Tiền nạp vào',
                        ),
                      ],
                    );
                  } else {
                    return const Center(child: Text('Khôgn có dữ liệu'));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TransactionData> calculateTransactionData(
      List<Transaction> transactions, String selectedPeriod) {
    Map<DateTime, double> dailyTransactionAmounts = {};

    for (var transaction in transactions) {
      DateTime date = DateTime.parse(transaction.creationDate);
      DateTime formattedDate = DateTime(date.year, date.month, date.day);
      double amount = transaction.amount.toDouble();

      dailyTransactionAmounts[formattedDate] ??= 0;
      if (transaction.transactionType == "Receive") {
        dailyTransactionAmounts[formattedDate] =
            dailyTransactionAmounts[formattedDate]! -
                amount; // Added null check
      } else {
        dailyTransactionAmounts[formattedDate] =
            dailyTransactionAmounts[formattedDate]! +
                amount; // Added null check
      }
    }

    List<TransactionData> result = [];
    dailyTransactionAmounts.forEach((date, amount) {
      String formattedDateString =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
      result.add(TransactionData(formattedDateString, amount));
    });

    // Sort the result by date and month
    result.sort((a, b) {
      var dateA = a.timePeriod.split('/');
      var dateB = b.timePeriod.split('/');
      var dayA = int.parse(dateA[0]);
      var dayB = int.parse(dateB[0]);
      var monthA = int.parse(dateA[1]);
      var monthB = int.parse(dateB[1]);

      if (monthA != monthB) {
        return monthA.compareTo(monthB);
      } else {
        return dayA.compareTo(dayB);
      }
    });

    if (selectedPeriod == 'Week') {
      // Add weekday abbreviations
      final weekdayAbbreviations = {
        1: 'T2', // Monday
        2: 'T3', // Tuesday
        3: 'T4', // Wednesday
        4: 'T5', // Thursday
        5: 'T6', // Friday
        6: 'T7', // Saturday
        7: 'CN', // Sunday
      };
      result = result.map((data) {
        var dateParts = data.timePeriod.split('/');
        var day = int.parse(dateParts[0]);
        var month = int.parse(dateParts[1]);
        // Use the year from the 'date' object
        var year = DateTime.now().year;
        var weekdayAbbreviation =
            weekdayAbbreviations[DateTime(year, month, day).weekday];
        var newTimePeriod = '$weekdayAbbreviation\n${data.timePeriod}';
        return TransactionData(newTimePeriod, data.amount);
      }).toList();
    }

    return result;
  }

  List<WalletLogData> calculateWalletLogData(
      List<WalletLog> walletLogs, String selectedPeriod) {
    Map<DateTime, double> dailyWalletLogAmounts = {};

    for (var log in walletLogs) {
      DateTime date = DateTime.parse(log.creationDate);
      DateTime formattedDate = DateTime(date.year, date.month, date.day);
      double amount = log.amount.toDouble();

      dailyWalletLogAmounts[formattedDate] ??= 0;

      dailyWalletLogAmounts[formattedDate] =
          dailyWalletLogAmounts[formattedDate]! + amount; // Added null check
    }

    List<WalletLogData> result = [];
    dailyWalletLogAmounts.forEach((date, amount) {
      String formattedDateString =
          '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
      result.add(WalletLogData(formattedDateString, amount));
    });

    // Sort the result by date and month
    result.sort((a, b) {
      var dateA = a.timePeriod.split('/');
      var dateB = b.timePeriod.split('/');
      var dayA = int.parse(dateA[0]);
      var dayB = int.parse(dateB[0]);
      var monthA = int.parse(dateA[1]);
      var monthB = int.parse(dateB[1]);

      if (monthA != monthB) {
        return monthA.compareTo(monthB);
      } else {
        return dayA.compareTo(dayB);
      }
    });

    if (selectedPeriod == 'Week') {
      // Add weekday abbreviations
      final weekdayAbbreviations = {
        1: 'T2', // Monday
        2: 'T3', // Tuesday
        3: 'T4', // Wednesday
        4: 'T5', // Thursday
        5: 'T6', // Friday
        6: 'T7', // Saturday
        7: 'CN', // Sunday
      };
      result = result.map((data) {
        var dateParts = data.timePeriod.split('/');
        var day = int.parse(dateParts[0]);
        var month = int.parse(dateParts[1]);
        // Use the year from the 'date' object
        var year = DateTime.now().year;
        var weekdayAbbreviation =
            weekdayAbbreviations[DateTime(year, month, day).weekday];
        var newTimePeriod = '$weekdayAbbreviation\n${data.timePeriod}';
        return WalletLogData(newTimePeriod, data.amount);
      }).toList();
    }

    return result;
  }
}

class TransactionData {
  final String timePeriod;
  final double amount;

  TransactionData(this.timePeriod, this.amount);
}

class WalletLogData {
  final String timePeriod;
  final double amount;

  WalletLogData(this.timePeriod, this.amount);
}
