import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart' hide Headers;

part 'payment_api.g.dart';

@RestApi()
abstract class PaymentApi {
  factory PaymentApi(Dio dio, {String baseUrl}) = _PaymentApi;

  // AUTH
  @GET('/auth/apple/generate-account')
  Future<HttpResponse<dynamic>> generateAccount();

  // PAYMENTS
  @GET('/payments/generate-and-save-braintree-client-token')
  Future<String> generateAndSaveBraintreeClientToken(@Header('Authorization') String? authorizationToken);

  @GET('/payments/update-client-token')
  Future<String> updateClientToken(@Header('Authorization') String? authorizationToken);

  @POST('/payments/add-payment-method')
  Future<String> addPaymentMethod(
      @Header('Authorization') String? authorizationToken,
      @Body() Map<String, dynamic> body);

  @POST('/payments/subscription/create-subscription-transaction-v2?disableWelcomeDiscount=false&welcomeDiscount=10')
  Future<void> createSubscriptionTransactionV2(@Body() Map<String, dynamic> body);

  @POST('/payments/rent-power-bank')
  Future<String> rentPowerBank(@Body() Map<String, dynamic> body);
}