import 'package:common_di/common_di.dart';
import 'package:common_ui/common_style.dart';
import 'package:common_ui/common_text.dart';
import 'package:common_ui/common_image.dart';
import 'package:common_ui/nullable_extension.dart';
import 'package:common_ui/number_extension.dart';
import 'package:flutter/material.dart';
import 'package:common_ui/common_bloc.dart';
import 'package:common_ui/common_widget.dart';
import 'package:product_domain/product_domain.dart';
import 'package:product_ui/src/bloc/product_detail_event.dart';
import 'package:product_ui/src/bloc/product_detail_state.dart';
import '../navigation/product_navigation.dart';
import '../bloc/product_detail_bloc.dart';

class ProductDetailPage extends StatelessWidget with Injectable {

  ProductDetailPage({
    required this.productId,
    this.variantId = 0,
    super.key,
  });

  final String productId;
  final int variantId;

  late final ProductNavigation _navigation = inject();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(inject())
        ..add(
          Load(
            productId: productId,
          ),
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
      title: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          return HeaderWidget(
            searchHint: "Find your needs here",
            searchRecommendation: const ["Android", "IOS", "Web"],
            onSearch: (text) {
              _navigation.navigateToProductList(context, text);
            },
            actions: [
              TextButtonOutlined.secondary("Sign in", onPressed: () => {}),
              TextButtonFilled.primary("Sign up", onPressed: () => {}),
            ],
          );
        },
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<ProductDetailBloc, ProductDetailState>(
      builder: (context, state) {
        final isLoading = state.isLoading.orFalse();
        final product = state.product;

        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (product == null) {
          return const Center(
            child: Text("PRODUCT NOT FOUND"),
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _imageWidget(product.imageUrl.orEmpty()),
                        const SizedBox(width: 24),
                        SizedBox(
                          width: 400,
                          height: 600,
                          child: _infoWidget(context, state),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Description',
                      style: CommonTypography.textBodyBold,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.description ?? "Empty Description",
                      style: CommonTypography.textBody,
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 24),
            ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(top: 24),
                child: SizedBox(
                  width: 300,
                  child: Column(
                    children: [
                      _priceWidget(context, product, variantId),
                      const SizedBox(height: 16),
                      _userWidget(
                        product.ownerName,
                        product.ownerImageUrl,
                        product.ownerProfileUrl,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _imageWidget(String imageUrl) {
    return ImageUrl.square(
      imageUrl,
      dimension: 600,
      radius: 14,
      padding: 2,
    );
  }

  Widget _infoWidget(BuildContext context, ProductDetailState state) {
    final title = state.title;
    final variants = state.product?.variants;
    final selectedVariantId = state.selectedVariant?.id;
    final product = state.product;

    if (product == null) return const SizedBox();

    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: CommonTypography.textHeading2),
            const SizedBox(height: 16),
            if (variants != null && selectedVariantId != null)
              _variantsWidget(
                selectedVariantId,
                variants,
                onSelectVariant: (variantId) {
                  context
                      .read<ProductDetailBloc>()
                      .add(SelectVariant(id: variantId));
                },
              ),
            const SizedBox(height: 8),
            const DividerLineSeparator(),
            const SizedBox(height: 8),
            const Text("Demo", style: CommonTypography.textBodyBold),
            _demoLinkWidget(product.demoLinks),
            const SizedBox(height: 8),
            const Text("Dev Tools", style: CommonTypography.textBodyBold),
            _devToolsWidget(product.devTools),
            const SizedBox(height: 8),
            SizedBox(
              height: 250,
              child: _tabSection(
                product.features,
                product.whatInside,
                product.previewFiles,
              ),
            ),
            const DividerLineSeparator(),
          ],
        ),
      ),
    );
  }

  Widget _variantsWidget(
    int? variantId,
    List<ProductVariant> variants, {
    Function(int)? onSelectVariant,
  }) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: variants.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        mainAxisExtent: 130,
      ),
      itemBuilder: (context, index) {
        final variant = variants[index];
        final isSelected = variant.id == variantId;
        return Column(
          children: [
            Container(
              decoration: CommonDecorations.boxOutlined(
                radius: 8,
                borderColor: isSelected
                    ? CommonColors.borderLineColorFocused
                    : CommonColors.borderLineColorNormal,
              ),
              width: 100,
              height: 100,
              child: InkWell(
                onTap: () => onSelectVariant?.call(variant.id.orZero()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    variant.imageUrl.orEmpty(),
                    fit: BoxFit.cover,
                    errorBuilder: (context, obj, stack) => const Placeholder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                variant.title.orEmpty(),
                style: CommonTypography.textBody,
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    );
  }

  Widget _demoLinkWidget(
    String? demoLinks,
  ) {
    final items = demoLinks?.split(";") ?? List.empty();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final link = LinkMarkdown(items[index]);
        return ListTile(
          title: Text(
            link.preview,
            style: CommonTypography.textLink,
          ),
        );
      },
    );
  }

  Widget _devToolsWidget(
    String? devTools,
  ) {
    final items = devTools?.split(";") ?? List.empty();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            items[index],
            style: CommonTypography.textBody,
          ),
        );
      },
    );
  }

  Widget _tabSection(
    String? feature,
    String? whatInside,
    String? preview,
  ) {
    return DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const DividerLineSeparator(),
          const TabBar(
            tabs: [
              Tab(text: "Feature"),
              Tab(text: "What Inside"),
              Tab(text: "File Preview"),
            ],
            labelStyle: CommonTypography.textBodyBold,
            unselectedLabelStyle: CommonTypography.textLightBold,
            unselectedLabelColor: CommonColors.textLightColor,
            labelColor: CommonColors.textBodyColor,
            indicatorColor: CommonColors.borderLineColorFocused,
          ),
          const DividerLineSeparator(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: TabBarView(
                children: [
                  Text(
                    feature ?? "Coming soon",
                    style: CommonTypography.textBody,
                  ),
                  Text(
                    whatInside ?? "Coming soon",
                    style: CommonTypography.textBody,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      const Icon(
                        Icons.remove_red_eye_outlined,
                        color: CommonColors.textLightColor,
                      ),
                      Text(
                        preview ?? "Not Available",
                        style: CommonTypography.textBody.copyWith(
                          color: CommonColors.textLightColor,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceWidget(BuildContext context, Product product, int? variantId) {
    final tax = (product.price.orZero() * 0.1).round();
    final totalPrice = product.price.orZero() + tax;
    return Container(
      decoration: CommonDecorations.boxOutlined(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Price", style: CommonTypography.textBody),
          const SizedBox(height: 8),
          Text(
            product.price.orZero().toIDR(),
            style: CommonTypography.textHeading2,
          ),
          const SizedBox(height: 16),
          const Text(
            "Tax 10%",
            style: CommonTypography.textBody,
          ),
          const SizedBox(height: 8),
          Text(
            tax.toIDR(),
            style: CommonTypography.textBody,
          ),
          const SizedBox(height: 16),
          const DividerLineSeparator(),
          const SizedBox(height: 16),
          const Text(
            "Total",
            style: CommonTypography.textBody,
          ),
          const SizedBox(height: 8),
          Text(
            totalPrice.toIDR(),
            style: CommonTypography.textHeading2,
          ),
          const SizedBox(height: 16),
          TextButtonFilled.primary(
            "Instant Buy",
            onPressed: () => _payment(
              context,
              product,
            ),
          ),
          // Todo : Sharing button
          // const SizedBox(height: 16),
          // TextButtonOutlined.secondary(
          //   "Share",
          //   onPressed: () {},
          // ),
        ],
      ),
    );
  }

  Widget _userWidget(
    String? ownerName,
    String? ownerImageUrl,
    String? ownerProfileUrl,
  ) {
    final profiles = ownerProfileUrl?.split(";");
    return Container(
      decoration: CommonDecorations.boxOutlined(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Contributor", style: CommonTypography.textHeading),
          const SizedBox(height: 16),
          const DividerLineSeparator(),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox.square(
                dimension: 32,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    ownerImageUrl.orEmpty(),
                    errorBuilder: (context, obj, stack) =>
                        const Icon(Icons.person_2_rounded),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(ownerName.orEmpty(), style: CommonTypography.textBodyBold),
            ],
          ),
          const SizedBox(height: 8),
          if (profiles != null)
            ListView.builder(
              shrinkWrap: true,
              itemCount: profiles.length,
              itemBuilder: (context, index) {
                final link = LinkMarkdown(profiles[index]);
                return Text(
                  link.preview,
                  style: CommonTypography.textLink,
                );
              },
            ),
        ],
      ),
    );
  }

  _payment(BuildContext context, Product product) {
    _navigation.navigateToPayment(
      context,
      product.productId.orZero(),
      variantId,
      product.imageUrl,
      product.title,
      product.variants
          .firstWhereOrNull((element) => element.id == variantId)
          ?.title,
      product.price,
      product.price.orZero() * 10 / 100,
    );
  }
}
