import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_powerbank_test_app/common/theme.dart';

class SuccessDescription extends StatelessWidget {
  const SuccessDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Stay Powered Anytime', style: AppTextStyles.interW400Black(AppFontSizes.sp24),),
          SizedBox(height: 16.w,),
          Text(
            'To return your power bank and keep enjoying our service for free, simply download the app!',
          style: AppTextStyles.interW300Black(AppFontSizes.sp20),
          textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}
