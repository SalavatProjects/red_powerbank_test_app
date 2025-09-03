import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final String stationId;

  const PaymentScreen({
    super.key,
    required this.stationId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Payment Screen for station: $stationId', style: const TextStyle(fontSize: 18, color: Colors.black)),
      ),
    );
  }
}
