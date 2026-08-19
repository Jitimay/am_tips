import 'package:flutter_test/flutter_test.dart';
import 'package:am_tips/core/utils/validators.dart';

void main() {
  group('Validators', () {
    test('required validator', () {
      expect(Validators.required(null), isNotNull);
      expect(Validators.required(''), isNotNull);
      expect(Validators.required('   '), isNotNull);
      expect(Validators.required('Valid text'), isNull);
    });

    test('email validator', () {
      expect(Validators.email(null), isNotNull);
      expect(Validators.email('invalid'), isNotNull);
      expect(Validators.email('user@'), isNotNull);
      expect(Validators.email('user@domain.com'), isNull);
    });

    test('phone validator', () {
      expect(Validators.phone(null), isNotNull);
      expect(Validators.phone('123'), isNotNull);
      expect(Validators.phone('+25779123456'), isNull);
      expect(Validators.phone('+257 79 123 456'), isNull);
    });

    test('password validator', () {
      expect(Validators.password(null), isNotNull);
      expect(Validators.password('1234567'), isNotNull);
      expect(Validators.password('12345678'), isNull);
    });

    test('confirmPassword validator', () {
      expect(Validators.confirmPassword('pass1', 'pass2'), isNotNull);
      expect(Validators.confirmPassword('password123', 'password123'), isNull);
    });

    test('fullName validator', () {
      expect(Validators.fullName(null), isNotNull);
      expect(Validators.fullName('John'), isNotNull);
      expect(Validators.fullName('John Doe'), isNull);
    });

    test('withdrawalAmount validator', () {
      expect(
        Validators.withdrawalAmount('500', availableBalance: 10000, min: 1000),
        isNotNull,
      );
      expect(
        Validators.withdrawalAmount('15000', availableBalance: 10000, min: 1000),
        'Insufficient balance.',
      );
      expect(
        Validators.withdrawalAmount('5000', availableBalance: 10000, min: 1000),
        isNull,
      );
    });
  });
}
