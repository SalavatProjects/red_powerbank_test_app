import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pay/pay.dart';
import 'package:red_powerbank_test_app/common/theme.dart';

import '../../../../gen/assets.gen.dart';

enum PaymentButtonType {
  applePay,
  googlePay,
  card,
}

class PaymentButton extends StatefulWidget {
  final VoidCallback onPressed;
  final PaymentButtonType type;

  const PaymentButton({
    super.key,
    required this.onPressed,
    required this.type,
  });

  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  late final Future<PaymentConfiguration> _applePayConfigFuture;
  late final Future<PaymentConfiguration> _googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
    _applePayConfigFuture = _getPaymentConfiguration('json/apple_pay.json');
    _googlePayConfigFuture = _getPaymentConfiguration('json/google_pay.json');
  }

  Future<PaymentConfiguration> _getPaymentConfiguration(String assetPath) async {
    return await PaymentConfiguration.fromAsset(assetPath);
  }

  @override
  Widget build(BuildContext context) {
    /*final Future<PaymentConfiguration> applePayConfigFuture =
        PaymentConfiguration.fromAsset('json/apple_pay.json');
    final Future<PaymentConfiguration> googlePayConfigFuture =
        PaymentConfiguration.fromAsset('json/google_pay.json');*/

    final paymentItem = PaymentItem(
      label: 'Total',
      amount: dotenv.get('PRICE'),
      status: PaymentItemStatus.final_price,
    );
    return switch (widget.type) {
      PaymentButtonType.applePay => FutureBuilder<PaymentConfiguration>(
        future: _applePayConfigFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          } else {
            return ApplePayButton(
              paymentConfiguration: snapshot.data!,
              paymentItems: [paymentItem],
              onPressed: widget.onPressed,
              style: ApplePayButtonStyle.black,
            );
          }

        }
      ),
      PaymentButtonType.googlePay => FutureBuilder<PaymentConfiguration>(
        future: _googlePayConfigFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          } else {
            return GooglePayButton(
              width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(vertical: 18.w),
                paymentConfiguration: snapshot.data!,
                paymentItems: [paymentItem],
                onPressed: widget.onPressed);
          }
        }
      ),
      PaymentButtonType.card => _CardPayButton(onPressed: widget.onPressed),
    };
  }
}

class _CardPayButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CardPayButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.w),
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        sizeStyle: CupertinoButtonSize.small,
        child: SizedBox(
          height: 48.w,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Assets.icons.card.svg(width: 32.w, height: 32.w,),
                  SizedBox(width: 12.w,),
                  Text(
                    'Debit or credit card',
                    style: AppTextStyles.interW400Black(AppFontSizes.sp16),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 18.w, color: AppColors.black,)
            ],
          ),
        ),
      ),
    );
  }
}
