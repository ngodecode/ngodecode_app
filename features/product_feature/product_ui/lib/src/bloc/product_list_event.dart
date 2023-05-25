abstract class ProductListEvent{}

class Load extends ProductListEvent {
  Load({this.page = 1, this.keyword});
  final int page;
  final String? keyword;
}

class LoadMore extends ProductListEvent {}