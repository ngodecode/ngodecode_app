import 'package:payment_ui/src/bloc/payment_state.dart';

abstract class PaymentEvent {}

class SelectPaymentMethod extends PaymentEvent {
  SelectPaymentMethod({required this.method, this.email});

  PaymentMethod method;
  String? email;
}

class SubmitInstantPay extends PaymentEvent {
  SubmitInstantPay({
    required this.productId,
    required this.variantId,
    required this.email,
    this.onError,
  });

  int productId;
  int variantId;
  String email;
  Function(dynamic)? onError;
}

class SubmitSaveToAccount extends PaymentEvent {}
