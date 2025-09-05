import 'package:flutter/material.dart';
import 'package:red_powerbank_test_app/common/theme.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: AppColors.lightGrey,
      height: 0.5,
    );
  }
}
