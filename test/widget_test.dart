import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bilinovel_app/main.dart';

void main() {
  testWidgets('home shows its main sections and ranking tabs', (tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('热门文库'), findsOneWidget);
    expect(find.text('榜单'), findsOneWidget);
    expect(find.text('Re:从零开始的异世界生活'), findsNWidgets(2));
    expect(find.byKey(const Key('ranking-tab-收藏')), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });

  testWidgets('ranking tab selection updates locally', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const Key('ranking-tab-点击')));
    await tester.pumpAndSettle();

    final selectedTab = tester.widget<Semantics>(
      find.byKey(const Key('ranking-tab-点击')),
    );
    expect(selectedTab.properties.selected, isTrue);
  });

  testWidgets('category navigation is an explicit placeholder', (tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byKey(const Key('bottom-tab-分类')));
    await tester.pumpAndSettle();

    expect(find.text('分类列表页将在后续阶段完成'), findsOneWidget);
  });

  testWidgets('home fits compact phone and landscape viewports', (
    tester,
  ) async {
    final view = tester.view;
    view.devicePixelRatio = 2;
    addTearDown(view.resetDevicePixelRatio);
    addTearDown(view.resetPhysicalSize);

    for (final size in const [Size(360, 720), Size(320, 640), Size(800, 360)]) {
      view.physicalSize = Size(size.width * 2, size.height * 2);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull, reason: 'viewport: $size');
    }
  });
}
