import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/withdrawal_model.dart';

abstract class WithdrawalRemoteDataSource {
  Future<WithdrawalModel> requestWithdrawal(Map<String, dynamic> data);
  Future<List<WithdrawalModel>> getWithdrawals({int page, int pageSize});
  Future<WithdrawalModel> getWithdrawal(String id);
}

class WithdrawalRemoteDataSourceImpl implements WithdrawalRemoteDataSource {
  final ApiClient apiClient;
  WithdrawalRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<WithdrawalModel> requestWithdrawal(Map<String, dynamic> data) async {
    final res = await apiClient.post(ApiEndpoints.withdrawals, data: data);
    return WithdrawalModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<List<WithdrawalModel>> getWithdrawals(
      {int page = 1, int pageSize = 20}) async {
    final res = await apiClient.get(
      ApiEndpoints.withdrawals,
      queryParameters: {'page': page, 'page_size': pageSize},
    );
    final list = res.data['data'] as List;
    return list
        .map((e) => WithdrawalModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<WithdrawalModel> getWithdrawal(String id) async {
    final res = await apiClient.get(ApiEndpoints.withdrawalById(id));
    return WithdrawalModel.fromJson(res.data as Map<String, dynamic>);
  }
}
