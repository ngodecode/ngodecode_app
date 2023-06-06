import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:product_ui/product_ui.dart';


class MockProductNavigation extends Mock implements ProductNavigation{}

void main() {
  group('ProductListPage', () {
    testWidgets('All components should be shown', (tester) async {
        // const widgetKey = Key('widget-key');
        // await tester.pumpWidget(ProductListPage(
        //   bloc: MockProductListBloc(),
        //   _navigation: MockProductNavigation(),
        //   key: widgetKey,
        // ));
        // expect(find.byKey(widgetKey), findsOneWidget);
    });
  });

}