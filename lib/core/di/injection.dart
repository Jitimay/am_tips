import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import '../network/api_client.dart';
import '../network/network_info.dart';
import '../network/sync_manager.dart';
import '../storage/isar_database_service.dart';
import '../storage/local_cache_service.dart';
import '../storage/secure_storage.dart';
import '../storage/supabase_storage_service.dart';
import '../services/push_notification_service.dart';

import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/data/datasources/firebase_auth_service.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/profile/data/datasources/profile_remote_datasource.dart';
import '../../features/profile/data/repositories/profile_repository_impl.dart';
import '../../features/profile/domain/repositories/profile_repository.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

import '../../features/tips/data/datasources/tips_remote_datasource.dart';
import '../../features/tips/data/repositories/tips_repository_impl.dart';
import '../../features/tips/domain/repositories/tips_repository.dart';
import '../../features/tips/presentation/bloc/tips_bloc.dart';
import '../../features/tips/presentation/bloc/wallet_cubit.dart';

import '../../features/qr_code/data/datasources/qr_remote_datasource.dart';
import '../../features/qr_code/data/repositories/qr_repository_impl.dart';
import '../../features/qr_code/domain/repositories/qr_repository.dart';
import '../../features/qr_code/presentation/bloc/qr_cubit.dart';

import '../../features/payments/data/datasources/payment_remote_datasource.dart';
import '../../features/payments/data/repositories/payment_repository_impl.dart';
import '../../features/payments/data/services/afripay_service.dart';
import '../../features/payments/domain/repositories/payment_repository.dart';
import '../../features/payments/presentation/bloc/payment_bloc.dart';

import '../../features/withdrawals/data/datasources/withdrawal_remote_datasource.dart';
import '../../features/withdrawals/data/repositories/withdrawal_repository_impl.dart';
import '../../features/withdrawals/domain/repositories/withdrawal_repository.dart';
import '../../features/withdrawals/presentation/bloc/withdrawal_bloc.dart';

import '../../features/notifications/data/datasources/notification_remote_datasource.dart';
import '../../features/notifications/data/repositories/notification_repository_impl.dart';
import '../../features/notifications/domain/repositories/notification_repository.dart';
import '../../features/notifications/presentation/bloc/notification_bloc.dart';

import '../../features/settings/data/repositories/settings_repository_impl.dart';
import '../../features/settings/domain/repositories/settings_repository.dart';
import '../../features/settings/presentation/bloc/settings_cubit.dart';

import '../../features/onboarding/presentation/bloc/onboarding_cubit.dart';

import '../../features/customer/bloc/customer_tip_bloc.dart';
import '../../features/customer/data/customer_tip_datasource.dart';
import '../../features/customer/data/customer_tip_repository_impl.dart';
import '../../features/customer/domain/customer_tip_repository.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // ── External ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(),
    ),
  );
  sl.registerLazySingleton<Connectivity>(() => Connectivity());

  // ── Core Storage & Offline Database ───────────────────────────────────────
  sl.registerLazySingleton<IsarDatabaseService>(
    () => IsarDatabaseService(),
  );
  sl.registerLazySingleton<LocalCacheService>(
    () => LocalCacheService(),
  );
  sl.registerLazySingleton<SecureStorage>(
    () => SecureStorage(storage: sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: sl<Connectivity>()),
  );
  sl.registerLazySingleton<SyncManager>(
    () => SyncManager(connectivity: sl<Connectivity>()),
  );
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(secureStorage: sl<SecureStorage>()),
  );
  sl.registerLazySingleton<SupabaseStorageService>(
    () => SupabaseStorageService(),
  );

  // ── Auth ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(authService: sl<FirebaseAuthService>()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: sl<AuthRemoteDataSource>(),
      secureStorage: sl<SecureStorage>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: sl<AuthRepository>()),
  );

  // ── Profile ───────────────────────────────────────────────────────────────
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(
      storageService: sl<SupabaseStorageService>(),
    ),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      remoteDataSource: sl<ProfileRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      isarDb: sl<IsarDatabaseService>(),
    ),
  );
  sl.registerFactory<ProfileBloc>(
    () => ProfileBloc(profileRepository: sl<ProfileRepository>()),
  );

  // ── Tips ──────────────────────────────────────────────────────────────────
  sl.registerLazySingleton<TipsRemoteDataSource>(
    () => TipsRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<TipsRepository>(
    () => TipsRepositoryImpl(
      remoteDataSource: sl<TipsRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      isarDb: sl<IsarDatabaseService>(),
    ),
  );
  sl.registerFactory<TipsBloc>(
    () => TipsBloc(tipsRepository: sl<TipsRepository>()),
  );
  sl.registerFactory<WalletCubit>(
    () => WalletCubit(tipsRepository: sl<TipsRepository>()),
  );

  // ── QR Code ───────────────────────────────────────────────────────────────
  sl.registerLazySingleton<QrRemoteDataSource>(
    () => QrRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<QrRepository>(
    () => QrRepositoryImpl(
      remoteDataSource: sl<QrRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      isarDb: sl<IsarDatabaseService>(),
    ),
  );
  sl.registerFactory<QrCubit>(
    () => QrCubit(qrRepository: sl<QrRepository>()),
  );

  // ── AfriPay + Payments ────────────────────────────────────────────────────
  sl.registerLazySingleton<AfriPayService>(
    () => AfriPayService(),
  );
  sl.registerLazySingleton<PaymentRemoteDataSource>(
    () => PaymentRemoteDataSourceImpl(
      afriPayService: sl<AfriPayService>(),
    ),
  );
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(
      remoteDataSource: sl<PaymentRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerFactory<PaymentBloc>(
    () => PaymentBloc(paymentRepository: sl<PaymentRepository>()),
  );

  // ── Withdrawals ───────────────────────────────────────────────────────────
  sl.registerLazySingleton<WithdrawalRemoteDataSource>(
    () => WithdrawalRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerLazySingleton<WithdrawalRepository>(
    () => WithdrawalRepositoryImpl(
      remoteDataSource: sl<WithdrawalRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      isarDb: sl<IsarDatabaseService>(),
    ),
  );
  sl.registerFactory<WithdrawalBloc>(
    () => WithdrawalBloc(withdrawalRepository: sl<WithdrawalRepository>()),
  );

  // ── Notifications ─────────────────────────────────────────────────────────
  sl.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      remoteDataSource: sl<NotificationRemoteDataSource>(),
      networkInfo: sl<NetworkInfo>(),
      isarDb: sl<IsarDatabaseService>(),
    ),
  );
  sl.registerFactory<NotificationBloc>(
    () => NotificationBloc(
        notificationRepository: sl<NotificationRepository>()),
  );

  // ── Settings ──────────────────────────────────────────────────────────────
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(apiClient: sl<ApiClient>()),
  );
  sl.registerFactory<SettingsCubit>(
    () => SettingsCubit(settingsRepository: sl<SettingsRepository>()),
  );

  // ── Onboarding ────────────────────────────────────────────────────────────
  sl.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(profileRepository: sl<ProfileRepository>()),
  );

  // ── Push Notifications ────────────────────────────────────────────────────
  sl.registerLazySingleton<PushNotificationService>(
    () => PushNotificationService(
      notificationRepository: sl<NotificationRepository>(),
      secureStorage: sl<SecureStorage>(),
    ),
  );

  // ── Customer tipping (AfriPay-backed, Supabase-direct) ───────────────────
  sl.registerLazySingleton<CustomerTipDataSource>(
    () => CustomerTipDataSourceImpl(
      afriPayService: sl<AfriPayService>(),
      paymentDataSource: sl<PaymentRemoteDataSource>(),
    ),
  );
  sl.registerLazySingleton<CustomerTipRepository>(
    () => CustomerTipRepositoryImpl(
      dataSource: sl<CustomerTipDataSource>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );
  sl.registerFactory<CustomerTipBloc>(
    () => CustomerTipBloc(repository: sl<CustomerTipRepository>()),
  );
}
