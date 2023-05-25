import 'package:common_di/common_di.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:flutter/material.dart';
import 'package:common_ui/common_bloc.dart';
import 'package:common_ui/common_widget.dart';
import 'package:product_domain/product_domain.dart';
import 'package:product_ui/product_ui.dart';
import '../bloc/product_list_bloc.dart';
import '../bloc/product_list_event.dart';
import '../bloc/product_list_state.dart';
import '../widget/product_card_widget.dart';

class ProductListPage extends StatelessWidget with Injectable {
  factory ProductListPage.withParam({
    Key? key,
    required Map<String, String> params,
  }) {
    return ProductListPage(
      key: key,
      keyword: params["keyword"],
    );
  }

  ProductListPage({super.key, this.keyword});

  final String? keyword;

  late final ProductNavigation _navigation = inject();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListBloc(inject())
        ..add(
          Load(keyword: keyword),
        ),
      child: Scaffold(
        appBar: _appBar(),
        body: _body(),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      toolbarHeight: 100,
      title: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          return HeaderWidget(
            searchHint: "Find your needs here",
            searchText: state.keyword,
            searchRecommendation: const ["Android", "IOS", "Web"],
            onSearch: (text) {
              context.read<ProductListBloc>().add(Load(keyword: text));
            },
            actions: [
              TextButtonOutlined.secondary("Sign in",
                  onPressed: () => _signIn(context)),
              TextButtonFilled.primary("Sign up",
                  onPressed: () => _signUp(context)),
            ],
          );
        },
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        final items = state.products.orEmpty();
        final hasMore = state.hasMore.orFalse();
        final isLoading = state.isLoading.orFalse();
        final isLoadingMore = state.isLoadingMore.orFalse();

        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (items.isEmpty) {
          return Center(
            child: TextButtonFilled(
              "Refresh",
              onPressed: () => context.read<ProductListBloc>().add(Load()),
            ),
          );
        }

        return CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(24),
              sliver: _gridWidget(items),
            ),
            _loadMoreWidget(
              hasMore,
              isLoadingMore,
              () => context.read<ProductListBloc>().add(LoadMore()),
            ),
          ],
        );
      },
    );
  }

  SliverToBoxAdapter _loadMoreWidget(
    bool hasMore,
    bool isLoading,
    Function() onLoadMore,
  ) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : hasMore
                ? Center(
                    child: TextButtonOutlined.primarySmall(
                      "Load more",
                      onPressed: onLoadMore,
                    ),
                  )
                : const SizedBox(),
      ),
    );
  }

  SliverGrid _gridWidget(List<Product> products) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final product = products[index];
          return ProductCardWidget.fromProduct(
            product: product,
            onTap: () => _openProductDetail(
              context,
              product.productId.orZero(),
            ),
          );
        },
        childCount: products.length,
      ),
    );
  }

  void _signIn(BuildContext context) {
    _navigation.navigateToSignIn(context);
  }

  void _signUp(BuildContext context) {
    _navigation.navigateToSignUp(context);
  }

  void _openProductDetail(BuildContext context, int productId) {
    _navigation.navigateToProductDetail(context, productId);
  }
}
