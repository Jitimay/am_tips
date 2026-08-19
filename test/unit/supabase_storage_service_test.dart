import 'package:am_tips/core/constants/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase Storage Constants & Bucket Configuration', () {
    test('bucket constants are correctly defined', () {
      expect(AppConstants.avatarsBucket, 'avatars');
      expect(AppConstants.qrBucket, 'qr-codes');
      expect(AppConstants.uploadsBucket, 'user-uploads');
      expect(AppConstants.supabaseUrl, isNotEmpty);
      expect(AppConstants.supabaseAnonKey, isNotEmpty);
    });

    test('storage path generation structure for avatars', () {
      const userId = 'user_abc123';
      final fileName = 'avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final path = '$userId/$fileName';

      expect(path.startsWith('user_abc123/avatar_'), isTrue);
      expect(path.endsWith('.jpg'), isTrue);
    });
  });
}
