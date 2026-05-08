import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pulse/main.dart';

void main() {
  testWidgets('PulseApp builds without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const PulseApp());
    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
  });
}
