import 'package:common_data/common_data.dart';
import 'package:payment_domain/payment_domain.dart';

class InvoiceModel extends Invoice {
  InvoiceModel({
    super.id,
    super.name,
    super.email,
    super.amount,
    super.adminFee,
    super.createdAt,
    super.expiredAt,
    super.paymentUrl,
    super.verifyUrl,
    super.paidAt,
    super.status,
  });

  factory InvoiceModel.fromJson(Map<String, dynamic> json) {
    return InvoiceModel(
      id: json.get('id'),
      name: json.get('name'),
      amount: json.get('amount'),
      email: json.get('email'),
      createdAt: json.get('created_at'),
      expiredAt: json.get('expired_at'),
      paymentUrl: json.get('payment_url'),
      verifyUrl: json.get('verify_url'),
      status: json.get('status'),
      paidAt: json.get('paid_at'),
    );
  }
}

class InvoiceMailModel {
  InvoiceMailModel({
    this.success,
    this.message,
  });

  final bool? success;
  final String? message;

  factory InvoiceMailModel.fromJson(Map<String, dynamic> json) {
    return InvoiceMailModel(
      success: json.get('success'),
      message: json.get('message'),
    );
  }
}
