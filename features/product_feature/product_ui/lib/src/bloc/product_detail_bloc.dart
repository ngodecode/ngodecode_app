import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:common_ui/common_bloc.dart';
import 'package:product_domain/product_domain.dart';
import 'product_detail_event.dart';
import 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final GetProductUseCase _getProductUseCase;

  ProductDetailBloc(this._getProductUseCase) : super(ProductDetailState()) {
    on<Load>(_load);
    on<SubmitBuy>(_submitBuy);
    on<SelectVariant>(_selectVariant);
  }

  void _load(Load event, Emitter emit) async {
    try {
      emit(state.copyWith(isLoading: true));
      await Future.delayed(Duration(seconds: Random(1).nextInt(3)));
      final product = await _getProductUseCase(productId: event.productId);
      emit(state.copyWith(
        isLoading: false,
        product: product,
      ));
    } catch (error, stack) {
      debugPrint(error.toString());
      debugPrint(stack.toString());
      emit(state.copyWith(isLoading: false));
    }
  }

  void _submitBuy(SubmitBuy event, Emitter emit) async {}

  void _selectVariant(SelectVariant event, Emitter emit) async {
    final variant = state.product?.variants?.firstWhere(
      (element) => element.id == event.id,
    );

    if (variant == null) {
      return;
    }

    emit(
      state.copyWith(
        product: state.product?.copyWith(
          imageUrl: variant.imageUrl,
        ),
      ),
    );
  }
}
