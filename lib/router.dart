import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:red_powerbank_test_app/features/success/presentation/screens/success_screen.dart';
import 'features/payment/presentation/screens/payment_screen.dart';
import 'dart:developer' as dev;

class _DeepLinkObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    dev.log('[NAV] push -> ${route.settings.name ?? route.settings.arguments}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    dev.log('[NAV] pop  <- ${route.settings.name}');
  }
}

abstract class AppRouter {
  // payment
  static const String paymentPath = '/payment';
  static const String paymentName = 'payment';

  // success
  static const String successPath = '/success';
  static const String successName = 'success';

  // TODO: get stationId from qr code
  static const String _stationId = 'RECH082203000350';

  static final GoRouter router = GoRouter(
      debugLogDiagnostics: true, // TODO: remove in production
      observers: [_DeepLinkObserver()],
      initialLocation: '$paymentPath?stationId=$_stationId',
      redirect: (context, state) {
        final location = state.uri.toString();
        dev.log('[ROUTER] redirect -> $location');
        return null;
      },
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
            },),
        GoRoute(
          path: successPath,
          name: successName,
          builder: (BuildContext context, GoRouterState state) {
            return SuccessScreen();
          },
        )
      ]);
}
