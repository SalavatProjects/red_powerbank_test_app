import 'package:dio/dio.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:red_powerbank_test_app/features/payment/domain/payment_repository.dart';
import 'package:red_powerbank_test_app/features/payment/utils/braintree_utils.dart';
import 'payment_api.dart';
import 'dart:developer' as dev;

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentApi _paymentApi;
  final Dio _dio;

  PaymentRepositoryImpl({
    required PaymentApi paymentApi,
    required Dio dio,
  })  : _paymentApi = paymentApi,
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
    dev.log('[API] Generated account with token: $_accessJwt');
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  Future<String> getClientToken() async {
    return await _paymentApi.generateAndSaveBraintreeClientToken(_accessJwt);
  }

  @override
  Future<String> updateClientToken() async {
    dev.log('[API] Updating client token...');
    return await _paymentApi.updateClientToken(_accessJwt);
  }

  @override
  Future<String> addPaymentMethod(
      {required String paymentToken, required String paymentType}) async {
    const maxAttempts = 2;
    String currentPaymentToken = paymentToken;

    for (int attempt = 0; attempt < 1; attempt++) {
      try {
        final nonce = await getBraintreeDropInNonce(clientToken: currentPaymentToken);
        if (nonce == null) {
          throw Exception('Failed to obtain payment nonce');
        }
        /*final request = BraintreeCreditCardRequest(
            cardNumber: '4111111111111111',
            expirationMonth: '12',
            expirationYear: '2026',
            cvv: '367'
        );
        final reqResult = await Braintree.tokenizeCreditCard(
            currentPaymentToken, request);
        if (reqResult == null || reqResult.nonce.isEmpty) {
          throw Exception('Failed to obtain payment nonce from Braintree');
        }*/
        final body = {
          'paymentNonceFromTheClient': nonce.nonce,
          'description': nonce.description,
          'paymentType': nonce.typeLabel,
        };
        dev.log('Attempt ${attempt + 1}: Adding payment method with body: $body');
        final response = await _paymentApi.addPaymentMethod(_accessJwt, body);
        if (response.isEmpty) {
          throw Exception('Failed to add payment method: response is empty');
        }
        return response;
      } on DioException catch (e) {
        dev.log(e.response?.data.toString() ?? e.message ?? 'DioException without response data');
        /*dev.log('DioException on attempt ${attempt + 1}: ${e.message}, response: ${e.response?.data}');

        final status = e.response?.statusCode;
        dev.log('Status code: $status ${status == 500} attempt: $attempt');
        dev.log('status == 500 && attempt == 0 ${status == 500 && attempt == 0}');
        // final message = e.response?.data['message'].toString() ?? e.message ?? '';
        // dev.log('Error message: $message');
        if (status == 500) {
          dev.log('hihi');
          currentPaymentToken = await updateClientToken();
          final nonce = await getBraintreeDropInNonce(clientToken: currentPaymentToken);
          if (nonce == null || nonce.isEmpty) {
            throw Exception('Failed to obtain payment nonce after token refresh');
          }
          dev.log('[API] Refreshed client token, retrying...');
          continue;
        }*/
        // rethrow;
      }
    }
    throw StateError('Unreachable code reached in addPaymentMethod');
  }

  @override
  Future<void> createSubscription(
      {required String paymentToken, required String planId}) async {
    final body = {
      'paymentToken': paymentToken,
      'thePlanId': planId,
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
