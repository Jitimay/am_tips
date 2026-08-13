import '../../../../core/constants/api_endpoints.dart';
import '../../../../core/network/api_client.dart';
import '../models/qr_code_model.dart';

abstract class QrRemoteDataSource {
  Future<QrCodeModel> getMyQrCode();
  Future<QrCodeModel> regenerateQrCode();
}

class QrRemoteDataSourceImpl implements QrRemoteDataSource {
  final ApiClient apiClient;
  QrRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<QrCodeModel> getMyQrCode() async {
    final res = await apiClient.get(ApiEndpoints.myQr);
    return QrCodeModel.fromJson(res.data as Map<String, dynamic>);
  }

  @override
  Future<QrCodeModel> regenerateQrCode() async {
    final res = await apiClient.post(ApiEndpoints.generateQr);
    return QrCodeModel.fromJson(res.data as Map<String, dynamic>);
  }
}
