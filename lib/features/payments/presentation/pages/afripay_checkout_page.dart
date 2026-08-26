import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/services/afripay_service.dart';

class AfriPayCheckoutPage extends StatefulWidget {
  final int amount;
  final String currency;
  final String clientToken;
  final String waiterName;
  final String waiterId;
  final String tipId;

  const AfriPayCheckoutPage({
    super.key,
    required this.amount,
    required this.currency,
    required this.clientToken,
    required this.waiterName,
    required this.waiterId,
    required this.tipId,
  });

  @override
  State<AfriPayCheckoutPage> createState() => _AfriPayCheckoutPageState();
}

class _AfriPayCheckoutPageState extends State<AfriPayCheckoutPage> {
  late final WebViewController _controller;
  bool _isLoading = true;
  Timer? _pollTimer;
  final AfriPayService _afriPayService = AfriPayService();

  @override
  void initState() {
    super.initState();
    _initWebView();
    _startPolling();
  }

  void _initWebView() {
    final comment = 'Tip for ${widget.waiterName} — amTips';

    final postHtml = '''
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Connecting to AfriPay</title>
  <style>
    body {
      font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      background-color: #f8f9fa;
      color: #333333;
    }
    .container {
      text-align: center;
      padding: 24px;
    }
    .spinner {
      border: 3px solid rgba(123, 95, 238, 0.15);
      width: 44px;
      height: 44px;
      border-radius: 50%;
      border-left-color: #7B5FEE;
      animation: spin 1s linear infinite;
      margin: 0 auto 20px;
    }
    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }
    p {
      font-size: 16px;
      font-weight: 500;
      color: #555;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="spinner"></div>
    <p>Connecting securely to AfriPay...</p>
  </div>
  <form id="afripayForm" action="${AppConstants.afriPayCheckoutUrl}" method="POST">
    <input type="hidden" name="amount" value="${widget.amount}">
    <input type="hidden" name="currency" value="${widget.currency}">
    <input type="hidden" name="comment" value="$comment">
    <input type="hidden" name="client_token" value="${widget.clientToken}">
    <input type="hidden" name="return_url" value="${AppConstants.afriPayReturnUrl}">
    <input type="hidden" name="app_id" value="${AppConstants.afriPayAppId}">
    <input type="hidden" name="app_secret" value="${AppConstants.afriPayAppSecret}">
  </form>
  <script>
    document.getElementById('afripayForm').submit();
  </script>
</body>
</html>
''';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('[AfriPay WebView] Page started: $url');
          },
          onPageFinished: (String url) {
            debugPrint('[AfriPay WebView] Page finished: $url');
            if (mounted) {
              setState(() => _isLoading = false);
            }
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('[AfriPay WebView] Navigating to: ${request.url}');
            if (request.url.startsWith(AppConstants.afriPayReturnUrl)) {
              _onPaymentDone();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadHtmlString(postHtml);
  }

  void _startPolling() {
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (_) async {
      final status = await _afriPayService.getPaymentStatus(widget.clientToken);
      if (status == 'completed') {
        _onPaymentDone();
      }
    });
  }

  bool _done = false;

  void _onPaymentDone() {
    if (_done) return;
    _done = true;
    _pollTimer?.cancel();
    if (!mounted) return;
    context.go(
      '/t/${widget.waiterId}/success',
      extra: {
        'tipId': widget.tipId,
        'amount': widget.amount,
        'currency': widget.currency,
        'waiterName': widget.waiterName,
        'waiterId': widget.waiterId,
      },
    );
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AfriPay Checkout'),
        leading: IconButton(
          icon: const Icon(Icons.close_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            ),
        ],
      ),
    );
  }
}
