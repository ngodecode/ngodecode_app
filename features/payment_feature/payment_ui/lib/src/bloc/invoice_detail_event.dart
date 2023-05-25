abstract class InvoiceDetailEvent {}

class LoadInvoice extends InvoiceDetailEvent {
  LoadInvoice({required this.id});

  final String id;
}
