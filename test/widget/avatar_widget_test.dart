import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:am_tips/core/widgets/avatar_widget.dart';

void main() {
  group('AvatarWidget', () {
    testWidgets('renders initials when no image provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AvatarWidget(name: 'Joshua Ndayishimiye'),
          ),
        ),
      );

      expect(find.text('JN'), findsOneWidget);
    });

    testWidgets('renders single initial for single name', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: AvatarWidget(name: 'Alice'),
          ),
        ),
      );

      expect(find.text('A'), findsOneWidget);
    });
  });
}
