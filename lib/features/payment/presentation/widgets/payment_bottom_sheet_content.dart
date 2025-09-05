import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentBottomSheetContent extends StatelessWidget {
  final VoidCallback onPressed;

  const PaymentBottomSheetContent({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 40.w),
          TextButton(onPressed: onPressed, child: Text('Pay')),
          SizedBox(height: 40.w),
        ],
      ),
    ));
  }
}
