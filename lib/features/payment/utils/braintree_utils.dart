import 'package:flutter_braintree/flutter_braintree.dart';
import 'dart:developer' as dev;

import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<BraintreePaymentMethodNonce?> getBraintreeDropInNonce({required String clientToken}) async {
  try {
    final request = BraintreeDropInRequest(
      clientToken: clientToken,
      collectDeviceData: true,
      amount: dotenv.get('PRICE'),
      googlePaymentRequest: BraintreeGooglePaymentRequest(
        totalPrice: dotenv.get('PRICE'),
        currencyCode: dotenv.get('CURRENCY'),
        billingAddressRequired: false,
      ),
      applePayRequest: BraintreeApplePayRequest(
        paymentSummaryItems: <ApplePaySummaryItem>[
          ApplePaySummaryItem(
            label: dotenv.get('MERCHANT_NAME'),
            amount: double.parse(dotenv.get('PRICE')),
            type: ApplePaySummaryItemType.final_,
          )
        ],
        displayName: 'displayName',
        currencyCode: dotenv.get('CURRENCY'),
        countryCode: 'US',
        merchantIdentifier: 'merchant.com.example',
        supportedNetworks: [
          ApplePaySupportedNetworks.visa,
          ApplePaySupportedNetworks.masterCard,
          ApplePaySupportedNetworks.amex,
          ApplePaySupportedNetworks.discover
        ],
      ),
      vaultManagerEnabled: true,
    );

    final result = await BraintreeDropIn.start(request);
    if (result == null) return null;
    final nonce = result.paymentMethodNonce;
    dev.log('Braintree nonce: $nonce');
    return nonce;
  } catch (e) {
    dev.log('Error obtaining Braintree nonce: $e');
    return null;
  }
}