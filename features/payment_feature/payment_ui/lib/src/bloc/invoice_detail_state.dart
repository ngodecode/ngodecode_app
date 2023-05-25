import 'package:payment_domain/payment_domain.dart';

class InvoiceDetailState {

  InvoiceDetailState({this.isLoading, this.invoice});

  final bool? isLoading;
  final Invoice? invoice;

  InvoiceDetailState copyWith({
    final bool? isLoading,
    final Invoice? invoice,
  }) {
    return InvoiceDetailState(
      isLoading: isLoading ?? this.isLoading,
      invoice: invoice ?? this.invoice,
    );
  }
}