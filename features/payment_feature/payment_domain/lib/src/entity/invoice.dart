class Invoice {
  final String? id;
  final String? name;
  final String? email;
  final double? amount;
  final double? adminFee;
  final String? createdAt;
  final String? expiredAt;
  final String? status;
  final String? paymentUrl;
  final String? verifyUrl;
  final String? paidAt;


  Invoice({
    this.id,
    this.name,
    this.email,
    this.amount,
    this.adminFee,
    this.createdAt,
    this.expiredAt,
    this.status,
    this.paymentUrl,
    this.verifyUrl,
    this.paidAt,
  });

  double getTotal()=> (amount ?? 0) + (adminFee ?? 0);
}
