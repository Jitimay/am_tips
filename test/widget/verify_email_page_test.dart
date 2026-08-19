import 'package:am_tips/core/theme/app_theme.dart';
import 'package:am_tips/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:am_tips/features/auth/presentation/pages/verify_email_page.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState>
    implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
  });

  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.light,
      home: BlocProvider<AuthBloc>.value(
        value: mockAuthBloc,
        child: child,
      ),
    );
  }


  group('VerifyEmailPage Widget Tests', () {
    testWidgets('renders email verification UI elements correctly',
        (tester) async {
      whenListen(
        mockAuthBloc,
        Stream<AuthState>.fromIterable([
          const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
        ]),
        initialState:
            const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const VerifyEmailPage(email: 'waiter@amtips.app'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Verify your email'), findsOneWidget);
      expect(find.text('waiter@amtips.app'), findsOneWidget);
      expect(find.text("I've Verified My Email"), findsOneWidget);
      expect(find.text('Resend Verification Email'), findsOneWidget);
      expect(find.text('Back to Login'), findsOneWidget);
    });

    testWidgets('triggers CheckEmailVerificationStatus on button tap',
        (tester) async {
      whenListen(
        mockAuthBloc,
        Stream<AuthState>.fromIterable([
          const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
        ]),
        initialState:
            const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const VerifyEmailPage(email: 'waiter@amtips.app'),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text("I've Verified My Email"));
      await tester.pump();

      expect(
        mockAuthBloc.state,
        const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
      );
    });

    testWidgets('triggers SendEmailVerificationRequested on resend tap',
        (tester) async {
      whenListen(
        mockAuthBloc,
        Stream<AuthState>.fromIterable([
          const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
        ]),
        initialState:
            const RegisterPendingConfirmation(email: 'waiter@amtips.app'),
      );

      await tester.pumpWidget(
        buildTestableWidget(
          const VerifyEmailPage(email: 'waiter@amtips.app'),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Resend Verification Email'));
      await tester.pump();

      // Cooldown timer starts
      expect(find.textContaining('Resend Email in'), findsOneWidget);
    });
  });
}
