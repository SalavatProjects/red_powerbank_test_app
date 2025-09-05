import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:red_powerbank_test_app/common/widgets/contact_support_widget.dart';
import 'package:red_powerbank_test_app/common/widgets/recharge_city_logo.dart';
import 'package:red_powerbank_test_app/features/success/presentation/widgets/download_app_button.dart';
import 'package:red_powerbank_test_app/features/success/presentation/widgets/success_description.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RechargeCityLogo(),
                SuccessDescription(),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DownloadAppButton(onPressed: () {
                      _launchUrl('https://apps.apple.com/us/app/recharge-city/id1594160460');
                    },),
                    SizedBox(height: 20.w),
                    ContactSupportWidget(onTap: () {})
                  ],
                ),
              ],
            ),
      )),
    );
  }
}
