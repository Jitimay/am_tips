import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/tip_model.dart';
import '../models/wallet_model.dart';

abstract class TipsRemoteDataSource {
  Future<List<TipModel>> getTips({
    String? filter,
    int page = 1,
    int pageSize = 20,
  });

  Future<TipModel> getTip(String id);
  Future<TipStatsModel> getTipStats();
  Future<WalletModel> getWallet();
  Future<List<WalletTransactionModel>> getTransactions({
    int page = 1,
    int pageSize = 20,
  });
}

class TipsRemoteDataSourceImpl implements TipsRemoteDataSource {
  final ApiClient apiClient;
  TipsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<TipModel>> getTips({
    String? filter,
    int page = 1,
    int pageSize = 20,
  }) async {
    final res = await apiClient.get(
      ApiEndpoints.tips,
      queryParameters: {
        if (filter != null) 'filter': filter,
        'page': page,
        'page_size': pageSize,
      },
    );
    final list = res.data['data'] as List;
    return list
        .map((e) => TipModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TipModel> getTip(String id) async {
    final res = await apiClient.get(ApiEndpoints.tipById(id));
    return TipModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<TipStatsModel> getTipStats() async {
    final res = await apiClient.get(ApiEndpoints.tipStats);
    return TipStatsModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<WalletModel> getWallet() async {
    final res = await apiClient.get(ApiEndpoints.wallet);
    return WalletModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<List<WalletTransactionModel>> getTransactions({
    int page = 1,
    int pageSize = 20,
  }) async {
    final res = await apiClient.get(
      ApiEndpoints.walletTransactions,
      queryParameters: {'page': page, 'page_size': pageSize},
    );
    final list = res.data['data'] as List;
    return list
        .map((e) => WalletTransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
