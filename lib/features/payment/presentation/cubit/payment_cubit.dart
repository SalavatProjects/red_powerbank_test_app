import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:red_powerbank_test_app/features/payment/domain/payment_repository.dart';
import 'payment_state.dart';

enum PaymentMethod {
  applePay('APPLE_PAY'),
  googlePay('GOOGLE_PAY'),
  card('CARD');

  final String title;

  const PaymentMethod(this.title);
}

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit({
    required PaymentRepository paymentRepository,
    required this.stationId,
}) : _paymentRepository = paymentRepository,
        super(const PaymentState.initial());

  final PaymentRepository _paymentRepository;
  final String stationId;

  final String _planId = dotenv.env['PLAN_ID'] ?? 'tss2';
  final String _connectionKey = 'TEST_CONNECTION_KEY_12345';

  Future<void> payWithApplePay(Map<String, dynamic> res) async {
    final paymentToken = _extractApplePayToken(res);
    if (paymentToken == null || paymentToken.isEmpty) {
      emit(const PaymentState.error('Failed to extract Apple Pay token'));
      return;
    }
    await payWithToken(
        paymentToken: paymentToken,
        paymentType: PaymentMethod.applePay.title,
    );
  }

  Future<void> payWithGooglePay(Map<String, dynamic> res) async {
    final paymentToken = _extractGooglePayToken(res);
    if (paymentToken == null || paymentToken.isEmpty) {
      emit(const PaymentState.error('Failed to extract Google Pay token'));
      return;
    }
    await payWithToken(
        paymentToken: paymentToken,
        paymentType: PaymentMethod.googlePay.title,
    );
  }

  Future<void> payWithToken({String? paymentToken, String? paymentType}) async {
    emit(const PaymentState.processing());
    try {
      await _paymentRepository.ensureAccount();
      final clientToken = await _paymentRepository.getClientToken();
      final paymentMethodId = await _paymentRepository.addPaymentMethod(
          paymentToken: paymentToken ?? clientToken,
          paymentType: paymentType ?? PaymentMethod.card.title
      );
      await _paymentRepository.createSubscription(
          paymentToken: paymentMethodId,
          planId: _planId
      );
      await _paymentRepository.rentPowerBank(
          cabinetId: stationId,
          connectionKey: _connectionKey,
      );
      emit(const PaymentState.success());
    } catch (e) {
      emit(PaymentState.error(e.toString()));
    }
  }

  String? _extractApplePayToken(Map<String, dynamic> res) {
    return (res['token']?['paymentToken'])?.toString();
  }

  String? _extractGooglePayToken(Map<String, dynamic> res) {
    final token = (res['paymentMethodData']?['tokenizationData']?['token'])?.toString();
    return (token ?? res['token'])?.toString();
  }
}
