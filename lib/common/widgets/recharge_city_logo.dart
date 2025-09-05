import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_powerbank_test_app/gen/assets.gen.dart';

class RechargeCityLogo extends StatelessWidget {
  const RechargeCityLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _LogoSquare(),
        SizedBox(width: 8.w),
        Assets.icons.rechargeCity.svg(),
      ],
    );
  }
}

class _LogoSquare extends StatelessWidget {
  const _LogoSquare({super.key});

  final List<Color> _gradientColors = const [
    Color(0xffF9FD57),
    Color(0xffD0FF1D),
    Color(0xff9DFF10),
    Color(0xff70FF02),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.w,
      height: 24.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _gradientColors,
        ),
      ),
    );
  }
}
