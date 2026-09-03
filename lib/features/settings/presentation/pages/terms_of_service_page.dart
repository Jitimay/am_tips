import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms of Service')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          _Section('Last updated: September 2026'),
          _Section('1. Acceptance of Terms',
              'By using amTips, you agree to these Terms of Service. If you do not agree, do not use the app.'),
          _Section('2. Description of Service',
              'amTips is a digital tipping platform that allows service workers, artists, content creators, and other professionals to receive tips from customers via QR code and mobile money.'),
          _Section('3. Account Registration',
              'You must provide accurate information when creating an account. You are responsible for maintaining the security of your account credentials.'),
          _Section('4. Payments & Fees',
              '• amTips charges a 10% platform fee on each tip received (4% AfriPay gateway fee + 6% amTips fee).\n'
              '• AfriPay charges a 3% fee on withdrawals — this is deducted by AfriPay directly.\n'
              '• amTips does not charge any additional fee on withdrawals.\n'
              '• All fees are displayed clearly before any transaction is confirmed.'),
          _Section('5. Withdrawals',
              'Withdrawal requests are processed via AfriPay to your registered mobile money account. Processing times depend on AfriPay and your mobile money provider. amTips is not responsible for delays caused by third-party payment processors.'),
          _Section('6. Prohibited Use',
              'You may not use amTips to:\n'
              '• Process fraudulent or unauthorized transactions.\n'
              '• Impersonate another person or entity.\n'
              '• Violate any applicable laws or regulations.'),
          _Section('7. Termination',
              'We reserve the right to suspend or terminate accounts that violate these terms or engage in fraudulent activity.'),
          _Section('8. Limitation of Liability',
              'amTips is not liable for any indirect, incidental, or consequential damages arising from your use of the service, including payment failures or delays caused by third-party providers.'),
          _Section('9. Changes to Terms',
              'We may update these terms at any time. Continued use of the app after changes constitutes acceptance of the new terms.'),
          _Section('10. Contact',
              'Questions? Contact us at: support@amtips.app'),
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
