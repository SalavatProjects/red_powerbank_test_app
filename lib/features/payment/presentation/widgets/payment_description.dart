import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_powerbank_test_app/common/theme.dart';
import 'package:red_powerbank_test_app/common/widgets/app_divider.dart';

class PaymentDescription extends StatelessWidget {
  const PaymentDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Monthly Subscription',
          style: AppTextStyles.interW400Black(AppFontSizes.sp26),
        ),
        SizedBox(
          height: 12.w,
        ),
        Row(
          children: [
            Text(
              '\$${dotenv.get('PRICE')}',
              style: AppTextStyles.interW400Black(AppFontSizes.sp38),
            ),
            SizedBox(
              width: 8.w,
            ),
            Text(
              '\$9.99',
              style: AppTextStyles.interW400Black(AppFontSizes.sp26).copyWith(
                  color: AppColors.black.withValues(alpha: 0.2),
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColors.black.withValues(alpha: 0.2)),
            ),
          ],
        ),
        SizedBox(height: 8.w,),
        Text('First month only',
          style: AppTextStyles.interW400Black(AppFontSizes.sp12).copyWith(
            color: AppColors.black.withValues(alpha: 0.4)
          ),
        ),
        SizedBox(height: 12.w,),
        AppDivider(),
      ],
    );
  }
}
