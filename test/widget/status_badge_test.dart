import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:am_tips/core/widgets/status_badge.dart';

void main() {
  group('StatusBadge', () {
    testWidgets('renders completed status badge', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatusBadge(status: BadgeStatus.completed),
          ),
        ),
      );

      expect(find.text('Completed'), findsOneWidget);
    });

    testWidgets('renders pending status badge', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: StatusBadge(status: BadgeStatus.pending),
          ),
        ),
      );

      expect(find.text('Pending'), findsOneWidget);
    });
  });
}
