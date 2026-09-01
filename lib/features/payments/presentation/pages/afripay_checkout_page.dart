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
    // Build the return_url the same way the web version does:
    // /t/{waiterId}/success?token={clientToken}
    final returnUrl =
        '${AppConstants.webBaseUrl}/t/${widget.waiterId}/success'
        '?token=${Uri.encodeComponent(widget.clientToken)}';

    // Use the web version's checkout-redirect page so the form submission
    // and AfriPay secret handling is identical to what works in the browser.
    final redirectUrl = Uri.parse(
      '${AppConstants.webBaseUrl}/t/${widget.waiterId}/checkout-redirect',
    ).replace(queryParameters: {
      'amount': widget.amount.toString(),
      'currency': widget.currency,
      'client_token': widget.clientToken,
      'comment': 'Tip for ${widget.waiterName} — amTips',
      'return_url': returnUrl,
    }).toString();

    final successUrlPrefix =
        '${AppConstants.webBaseUrl}/t/${widget.waiterId}/success';

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            debugPrint('[AfriPay WebView] Page started: $url');
          },
          onPageFinished: (String url) {
            debugPrint('[AfriPay WebView] Page finished: $url');
            if (mounted) setState(() => _isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('[AfriPay WebView] Navigating to: ${request.url}');
            if (request.url.startsWith(successUrlPrefix)) {
              _onPaymentDone();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(redirectUrl));
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
