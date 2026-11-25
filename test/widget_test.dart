// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/widgets.dart' show Size;
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('portfolio home displays its profile and menu', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(MyApp(apiClient: ApiClient()));

    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Selamat datang di MyPortfolio Mobile!'), findsOneWidget);
    expect(find.text('2506544990'), findsOneWidget);
    expect(find.text('Elvis'), findsOneWidget);
    expect(find.text('PBP B'), findsOneWidget);
    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Proyek'), findsOneWidget);

    expect(tester.takeException(), isNull);

    tester.view.physicalSize = const Size(900, 1000);
    await tester.pump();

    expect(find.text('Lihat Proyek'), findsOneWidget);
    expect(find.text('Tambah Sertifikasi'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
