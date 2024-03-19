import 'package:json_annotation/json_annotation.dart';

part 'transaction_model.g.dart';

@JsonSerializable()
class Transaction {
  num amount;
  String transactionType;
  String walletId;
  String paymentId;
  String creationDate;

  Transaction({
    required this.amount,
    required this.transactionType,
    required this.walletId,
    required this.paymentId,
    required this.creationDate,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}
