import 'package:common_ui/common_bloc.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:payment_domain/payment_domain.dart';
import 'package:payment_ui/src/bloc/payment_event.dart';
import 'package:payment_ui/src/bloc/payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc(
    this._createInvoiceUseCase,
    this._sendInvoiceMailUseCase, {
    required int productId,
    required int variantId,
  }) : super(PaymentState(productId: productId, variantId: variantId)) {
    on<SelectPaymentMethod>(_selectPaymentMethod);
    on<SubmitInstantPay>(_submitInstantPay);
  }

  final CreateInvoiceUseCase _createInvoiceUseCase;
  final SendInvoiceMailUseCase _sendInvoiceMailUseCase;

  _selectPaymentMethod(SelectPaymentMethod event, Emitter emit) {
    emit(state.copyWith(
      paymentMethod: event.method,
      email: event.email,
    ));
  }

  _submitInstantPay(SubmitInstantPay event, Emitter emit) async {
    try {
      emit(state.copyWith(isSubmitting: true));
      final result = await _createInvoiceUseCase(
        productId: event.productId,
        variantId: event.variantId,
        email: event.email,
      );
      await _sendInvoiceMailUseCase(invoiceId: result.id.orEmpty());
      emit(state.copyWith(
        isSubmitting: false,
        invoice: result,
      ));
    } catch (e) {
      emit(state.copyWith(isSubmitting: false, error: e));
    }

  }
}
