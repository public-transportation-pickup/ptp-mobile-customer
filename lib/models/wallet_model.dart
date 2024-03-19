import 'package:capstone_ptp/models/transaction_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'wallet_model.g.dart';

@JsonSerializable()
class Wallet {
  String id;
  String name;
  num amount;
  String walletType;
  String userId;
  String? storeId;
  List<Transaction> transactions;

  Wallet({
    required this.id,
    required this.name,
    required this.amount,
    required this.walletType,
    required this.userId,
    required this.transactions,
    this.storeId,
  });

  factory Wallet.fromJson(Map<String, dynamic> json) => _$WalletFromJson(json);

  Map<String, dynamic> toJson() => _$WalletToJson(this);
}
