import 'package:json_annotation/json_annotation.dart';

part 'wallet_log_model.g.dart';

@JsonSerializable()
class WalletLog {
  num amount;
  String source;
  String? transactionType;
  String type;
  String walletId;
  String creationDate;

  WalletLog({
    required this.amount,
    required this.source,
    this.transactionType,
    required this.type,
    required this.walletId,
    required this.creationDate,
  });

  factory WalletLog.fromJson(Map<String, dynamic> json) =>
      _$WalletLogFromJson(json);

  Map<String, dynamic> toJson() => _$WalletLogToJson(this);
}
