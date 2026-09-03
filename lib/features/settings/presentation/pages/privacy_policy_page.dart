import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy Policy')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          _Section('Last updated: September 2026'),
          _Section('1. Introduction',
              'amTips ("we", "our", "us") operates the amTips mobile application. This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our app.'),
          _Section('2. Data We Collect',
              '• Account information: name, email address, profile photo, profession, and workplace.\n'
              '• Payment information: mobile money phone numbers used for tips and withdrawals. We do not store card numbers.\n'
              '• Usage data: tip history, wallet balance, notification preferences.\n'
              '• Device data: Firebase Cloud Messaging token for push notifications.'),
          _Section('3. How We Use Your Data',
              '• To operate your account and process tips and withdrawals.\n'
              '• To send you notifications about tips received and withdrawal status.\n'
              '• To generate your personal QR code for receiving tips.\n'
              '• To improve the app and fix issues via crash reports (Firebase Crashlytics).'),
          _Section('4. Data Sharing',
              'We do not sell your personal data. We share data only with:\n'
              '• AfriPay: to process payments and disbursements.\n'
              '• Supabase: our database and storage provider.\n'
              '• Firebase (Google): for authentication, push notifications, and crash reporting.'),
          _Section('5. Public Profile',
              'Your name, photo, profession, city, and personal message are visible to anyone who scans your QR code or visits your tip page. Your email address and payment details are never public.'),
          _Section('6. Data Retention',
              'We retain your data for as long as your account is active. You may request deletion of your account and data by contacting us at support@amtips.app.'),
          _Section('7. Security',
              'We use industry-standard security measures including encrypted connections (HTTPS/TLS), row-level security on our database, and secure storage for sensitive credentials.'),
          _Section('8. Children\'s Privacy',
              'amTips is not directed at children under 13. We do not knowingly collect data from children under 13.'),
          _Section('9. Changes to This Policy',
              'We may update this policy from time to time. We will notify you of significant changes via the app or email.'),
          _Section('10. Contact Us',
              'If you have questions about this policy, contact us at:\nsupport@amtips.app'),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final String? body;
  const _Section(this.title, [this.body]);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: AppTextStyles.bodyMedium
                  .copyWith(fontWeight: FontWeight.w700, color: AppColors.primary)),
          if (body != null) ...[
            const SizedBox(height: 6),
            Text(body!, style: AppTextStyles.bodySmall.copyWith(height: 1.6)),
          ],
        ],
      ),
    );
  }
}
