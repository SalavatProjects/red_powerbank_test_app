import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_powerbank_test_app/common/theme.dart';

class DownloadAppButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DownloadAppButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      sizeStyle: CupertinoButtonSize.small,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 48.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
              colors: AppColors.greenGradient,
          )
        ),
        child: Center(
          child: Text(
            'Download App',
            style: AppTextStyles.interW300Black(AppFontSizes.sp18),
          ),
        ),
      ),
    );
  }
}
