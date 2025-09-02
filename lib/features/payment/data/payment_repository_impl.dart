import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:red_powerbank_test_app/features/payment/domain/payment_repository.dart';
import 'payment_api.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentApi _paymentApi;
  final Dio _dio;

  PaymentRepositoryImpl({
    required PaymentApi paymentApi,
    required Dio dio,
  }) : _paymentApi = paymentApi,
       _dio = dio;

  String? _accessJwt;

  @override
  Future<void> ensureAccount() async {
    if (_accessJwt != null) return;
    final response = await _paymentApi.generateAccount();
    final responseData = response.data;
    final token = responseData['accessJwt'] as String?;
    if (token == null || token.isEmpty) {
      throw Exception('Failed to generate account: accessJwt is null');
    }
    _accessJwt = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future<String> getClientToken() async {
    return await _paymentApi.generateAndSaveBraintreeClientToken();
  }

  @override
  Future<String> addPaymentMethod({required String paymentToken}) async {
    final body = {
      'paymentNonceFromTheClient': paymentToken,
      'description': 'Apple Pay',
      'paymentType': 'APPLE_PAY',
    };

    final response = await _paymentApi.addPaymentMethod(body);
    if (response.isEmpty) {
      throw Exception('Failed to add payment method: response is empty');
    }
    return response;
  }

  @override
  Future<void> createSubscription({required String paymentToken}) async {
    final body = {
      'paymentToken': paymentToken,
      'thePlanId': dotenv.env['PLAN_ID'] ?? 'tss2',
    };
    return await _paymentApi.createSubscriptionTransactionV2(body);
  }

  @override
  Future<String> rentPowerBank({
    required String cabinetId,
    required String connectionKey,
}) async {
    final body = {
      'cabinetId': cabinetId,
      'connectionKey': connectionKey,
    };
    final response = await _paymentApi.rentPowerBank(body);
    if (response.isEmpty) {
      throw Exception('Failed to rent power bank: response is empty');
    }
    return response;
  }
}