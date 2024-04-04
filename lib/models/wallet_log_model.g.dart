// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletLog _$WalletLogFromJson(Map<String, dynamic> json) => WalletLog(
      amount: json['amount'] as num,
      source: json['source'] as String,
      walletId: json['walletId'] as String,
      type: json['type'] as String,
      creationDate: json['creationDate'] as String,
      transactionType: '',
    );

Map<String, dynamic> _$WalletLogToJson(WalletLog instance) => <String, dynamic>{
      'amount': instance.amount,
      'source': instance.source,
      'walletId': instance.walletId,
      'type': instance.type,
      'creationDate': instance.creationDate,
      'transactionType': '',
    };
