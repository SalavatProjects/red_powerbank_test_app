import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:red_powerbank_test_app/common/theme.dart';

class ContactSupportWidget extends StatelessWidget {
  final VoidCallback onTap;

  const ContactSupportWidget({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
          text: 'Nothing happened? ',
          style: AppTextStyles.interW400Grey(AppFontSizes.sp10),
          children: [
            TextSpan(
              text: 'Contact Support',
              style: AppTextStyles.interW400Grey(AppFontSizes.sp10).copyWith(
                decoration: TextDecoration.underline,
                decorationColor: AppColors.grey,
              ),

              recognizer: TapGestureRecognizer()..onTap = onTap,
            ),
          ]
        ));
  }
}
