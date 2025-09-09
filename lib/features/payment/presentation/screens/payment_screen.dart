import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:red_powerbank_test_app/common/widgets/app_divider.dart';
import 'package:red_powerbank_test_app/common/widgets/contact_support_widget.dart';
import 'package:red_powerbank_test_app/common/widgets/recharge_city_logo.dart';
import 'package:red_powerbank_test_app/common/widgets/show_app_modal_bottom_sheet.dart';
import 'package:red_powerbank_test_app/core/di/di.dart';
import 'package:red_powerbank_test_app/features/payment/domain/payment_repository.dart';
import 'package:red_powerbank_test_app/features/payment/presentation/cubit/payment_cubit.dart';
import 'package:red_powerbank_test_app/features/payment/presentation/cubit/payment_state.dart';
import 'package:red_powerbank_test_app/features/payment/presentation/widgets/payment_bottom_sheet_content.dart';
import 'package:red_powerbank_test_app/features/payment/presentation/widgets/payment_button.dart';
import 'package:red_powerbank_test_app/features/payment/presentation/widgets/payment_description.dart';
import 'package:red_powerbank_test_app/router.dart';

class PaymentScreen extends StatelessWidget {
  final String stationId;

  const PaymentScreen({
    super.key,
    required this.stationId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PaymentCubit(
          paymentRepository: getIt<PaymentRepository>(), stationId: stationId),
      child: _PaymentScreen(stationId: stationId),
    );
  }
}

class _PaymentScreen extends StatelessWidget {
  final String stationId;

  const _PaymentScreen({
    required this.stationId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        switch (state) {
          case Success():
            context.goNamed(AppRouter.successName);
            break;
          case Error(:final message):
            Scaffold(
              body: Center(child: Text(message)),
            );
        }
      },
      builder: (context, state) {
        switch (state) {
          case Initial():
            return Scaffold(
              body: SafeArea(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RechargeCityLogo(),
                    SizedBox(height: 48.w),
                    PaymentDescription(),
                    SizedBox(height: 14.w),
                    PaymentButton(
                  onPressed: () {
                    // context.read<PaymentCubit>().payWithApplePay(res);
                  },
                  type: PaymentButtonType.applePay,
              ),
                    PaymentButton(
                      onPressed: () => showAppModalBottomSheet(
                          context: context,
                          child: PaymentBottomSheetContent(
                            onPressed: () {
                              context.pop();
                              // context.goNamed(AppRouter.successName);
                              context.read<PaymentCubit>().payViaCard();
                            },
                          )),
                      type: PaymentButtonType.card,
                    ),
                    AppDivider(),
                    PaymentButton(
                      onPressed: () {},
                      type: PaymentButtonType.googlePay,
                    ),
                    Spacer(),
                    Center(child: ContactSupportWidget(onTap: () {}))
                  ],
                ),
              )),
            );
          case Processing():
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case Error(:final message):
            return Scaffold(
              body: Center(child: Text(message)),
            );
          default:
            return Scaffold(
              body: Center(child: Text('Unknown state')),
            );
        }
      },
    );
  }
}
