import 'package:common_ui/common_bloc.dart';
import 'package:payment_domain/payment_domain.dart';
import 'package:payment_ui/src/bloc/invoice_detail_event.dart';
import 'package:payment_ui/src/bloc/invoice_detail_state.dart';

class InvoiceDetailBloc extends Bloc<InvoiceDetailEvent, InvoiceDetailState> {
  InvoiceDetailBloc(
    this._getInvoiceDetailUseCase,
  ) : super(InvoiceDetailState()) {
    on<LoadInvoice>(_onLoad);
  }

  final GetInvoiceDetailUseCase _getInvoiceDetailUseCase;

  void _onLoad(LoadInvoice event, Emitter emit) async {
    emit(state.copyWith(
      isLoading: true,
    ));
    final invoice = await _getInvoiceDetailUseCase(id: event.id);
    emit(state.copyWith(
      isLoading: false,
      invoice: invoice,
    ));
  }
}
