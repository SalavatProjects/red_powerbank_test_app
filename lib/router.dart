import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:red_powerbank_test_app/features/success/presentation/screens/success_screen.dart';

import 'features/payment/presentation/screens/payment_screen.dart';

abstract class AppRouter {
  static const String paymentPath = '/payment';
  static const String paymentName = 'payment';

  static const String successPath = 'success';
  static const String successName = 'success';

  static const String _stationId = 'RECH082203000350';

  static final GoRouter router = GoRouter(
      debugLogDiagnostics: true, // TODO: remove in production
      initialLocation: '$paymentPath?stationId=$_stationId',
      routes: [
        GoRoute(
            path: paymentPath,
            name: paymentName,
            builder: (BuildContext context, GoRouterState state) {
              final stationId = state.uri.queryParameters['stationId'];
              if (stationId == null) {
                throw Exception('stationId is required');
              }
              return PaymentScreen(stationId: stationId);
            },
            routes: [
              GoRoute(
                path: successPath,
                name: successName,
                builder: (BuildContext context, GoRouterState state) {
                  return SuccessScreen();
                },
              )
            ]),
      ]);
}
