import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:common_ui/common_bloc.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:product_domain/product_domain.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final GetProductPaginatedUseCase _getProductsUseCase;

  ProductListBloc(this._getProductsUseCase) : super(ProductListState()) {
    on<Load>(_load);
    on<LoadMore>(_loadMore);
  }

  void _load(Load event, Emitter emit) async {
    try {
      emit(state.copyWith(
        page: event.page,
        keyword: event.keyword,
        isLoading: true,
      ));
      await Future.delayed(Duration(seconds: Random(1).nextInt(3)));
      final data = await _getProductsUseCase(page: event.page);
      emit(state.copyWith(
        isLoading: false,
        products: data.products,
        hasMore: data.page.orZero() < data.totalPage.orZero(),
      ));
    } catch (error, stack) {
      debugPrint(error.toString());
      debugPrint(stack.toString());
      emit(state.copyWith(isLoading: false));
    }
  }

  void _loadMore(LoadMore event, Emitter emit) async {
    try {
      emit(state.copyWith(isLoadingMore: true));
      await Future.delayed(const Duration(seconds: 5));
      final data = await _getProductsUseCase(page: state.page.orZero() + 1);
      emit(state.copyWith(
        isLoadingMore: false,
        products: state.products.orEmpty() + data.products.orEmpty(),
        hasMore: data.page.orZero() < data.totalPage.orZero(),
        page: data.page,
      ));
    } catch (error) {
      debugPrint(error.toString());
      emit(state.copyWith(isLoadingMore: false));
    }
  }
}
