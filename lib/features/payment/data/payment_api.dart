import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'payment_api.g.dart';

@RestApi()
abstract class PaymentApi {
  factory PaymentApi(Dio dio, {String baseUrl}) = _PaymentApi;

  // AUTH
  @GET('/auth/apple/generate-account')
  Future<HttpResponse<dynamic>> generateAccount();

  // PAYMENTS
  @GET('/payments/generate-and-save-braintree-client-token')
  Future<String> generateAndSaveBraintreeClientToken();

  @POST('/payments/add-payment-method')
  Future<String> addPaymentMethod(@Body() Map<String, dynamic> body);

  @POST('/payments/subscription/create-subscription-transaction-v2?disableWelcomeDiscount=false&welcomeDiscount=10')
  Future<void> createSubscriptionTransactionV2(@Body() Map<String, dynamic> body);

  @POST('/payments/rent-power-bank')
  Future<String> rentPowerBank(@Body() Map<String, dynamic> body);
}