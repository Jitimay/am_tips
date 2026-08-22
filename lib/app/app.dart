import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injection.dart';
import '../core/router/app_router.dart';
import '../core/services/push_notification_service.dart';
import '../core/theme/app_theme.dart';
import '../features/auth/presentation/bloc/auth_bloc.dart';
import '../features/customer/bloc/customer_tip_bloc.dart';
import '../features/notifications/domain/entities/notification.dart';
import '../features/notifications/presentation/bloc/notification_bloc.dart';
import '../features/onboarding/presentation/bloc/onboarding_cubit.dart';
import '../features/payments/presentation/bloc/payment_bloc.dart';
import '../features/profile/presentation/bloc/profile_bloc.dart';
import '../features/qr_code/presentation/bloc/qr_cubit.dart';
import '../features/settings/presentation/bloc/settings_cubit.dart';
import '../features/tips/presentation/bloc/tips_bloc.dart';
import '../features/tips/presentation/bloc/wallet_cubit.dart';
import '../features/withdrawals/presentation/bloc/withdrawal_bloc.dart';

class AmTipsApp extends StatelessWidget {
  const AmTipsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => sl<AuthBloc>(),
        ),
        BlocProvider<OnboardingCubit>(
          create: (_) => sl<OnboardingCubit>(),
        ),
        BlocProvider<ProfileBloc>(
          create: (_) => sl<ProfileBloc>(),
        ),
        BlocProvider<TipsBloc>(
          create: (_) => sl<TipsBloc>(),
        ),
        BlocProvider<WalletCubit>(
          create: (_) => sl<WalletCubit>(),
        ),
        BlocProvider<QrCubit>(
          create: (_) => sl<QrCubit>(),
        ),
        BlocProvider<PaymentBloc>(
          create: (_) => sl<PaymentBloc>(),
        ),
        BlocProvider<WithdrawalBloc>(
          create: (_) => sl<WithdrawalBloc>(),
        ),
        BlocProvider<NotificationBloc>(
          create: (_) => sl<NotificationBloc>(),
        ),
        BlocProvider<SettingsCubit>(
          create: (_) => sl<SettingsCubit>(),
        ),
        BlocProvider<CustomerTipBloc>(
          create: (_) => sl<CustomerTipBloc>(),
        ),
      ],
      child: _NotificationLifecycleWrapper(
        child: BlocBuilder<SettingsCubit, SettingsState>(
          buildWhen: (prev, curr) => prev.isDarkMode != curr.isDarkMode,
          builder: (context, settings) {
            return MaterialApp.router(
              title: 'amTips',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode:
                  settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              routerConfig: AppRouter.router,
            );
          },
        ),
      ),
    );
  }
}

class _NotificationLifecycleWrapper extends StatefulWidget {
  final Widget child;
  const _NotificationLifecycleWrapper({required this.child});

  @override
  State<_NotificationLifecycleWrapper> createState() =>
      _NotificationLifecycleWrapperState();
}

class _NotificationLifecycleWrapperState
    extends State<_NotificationLifecycleWrapper> {
  StreamSubscription? _notifSub;

  @override
  void initState() {
    super.initState();
    _notifSub = sl<PushNotificationService>()
        .onNotificationReceived
        .listen(_handleNotification);
  }

  void _handleNotification(AppNotification notif) {
    if (!mounted) return;
    context.read<NotificationBloc>().add(NotificationReceived(notif));

    if (notif.type == NotificationType.newTip) {
      context.read<TipsBloc>().add(const LoadTips());
      context.read<WalletCubit>().refreshWallet();
    } else if (notif.type == NotificationType.withdrawalCompleted ||
        notif.type == NotificationType.withdrawalFailed) {
      context.read<WalletCubit>().refreshWallet();
    }
  }

  @override
  void dispose() {
    _notifSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, authState) {
        if (authState is Authenticated) {
          sl<PushNotificationService>().syncToken();
          context.read<NotificationBloc>().add(const NotificationsLoaded());
        } else if (authState is Unauthenticated) {
          sl<PushNotificationService>().deleteToken();
        }
      },
      child: widget.child,
    );
  }
}
