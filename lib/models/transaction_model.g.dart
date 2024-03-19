// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
      amount: json['amount'] as num,
      transactionType: json['transactionType'] as String,
      walletId: json['walletId'] as String,
      paymentId: json['paymentId'] as String,
      creationDate: json['creationDate'] as String,
    );

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'transactionType': instance.transactionType,
      'walletId': instance.walletId,
      'paymentId': instance.paymentId,
      'creationDate': instance.creationDate,
    };
