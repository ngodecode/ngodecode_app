import 'package:payment_domain/payment_domain.dart';

enum PaymentMethod { instant, saveToAccount }

class PaymentState {
  PaymentState({
    required this.productId,
    required this.variantId,
    this.email,
    this.paymentMethod,
    this.invoice,
    this.isSubmitting,
  });

  int productId;
  int variantId;
  String? email;
  PaymentMethod? paymentMethod;
  Invoice? invoice;
  bool? isSubmitting;

  bool isPageMethod() => invoice == null && paymentMethod == null && email == null;
  bool isPageConfirm() => invoice == null && paymentMethod != null && email != null;
  bool isPageCompleted() => invoice != null;

  PaymentState copyWith({
    int? productId,
    int? variantId,
    String? email,
    PaymentMethod? paymentMethod,
    Invoice? invoice,
    bool? isSubmitting,
  }) {
    return PaymentState(
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      email: email ?? this.email,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      invoice: invoice ?? this.invoice,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}
