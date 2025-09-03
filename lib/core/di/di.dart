import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:red_powerbank_test_app/core/network/dio_network.dart';
import 'package:red_powerbank_test_app/features/payment/data/payment_api.dart';
import 'package:red_powerbank_test_app/features/payment/domain/payment_repository.dart';
import 'package:red_powerbank_test_app/features/payment/data/payment_repository_impl.dart';

final _getIt = GetIt.instance;

Future<void> initDi() async {
  _getIt.registerLazySingleton<Dio>(DioNetwork.createDio);
  _getIt.registerLazySingleton<PaymentApi>(() => PaymentApi(_getIt<Dio>()));
  _getIt.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl(
        paymentApi: _getIt<PaymentApi>(),
        dio: _getIt<Dio>(),
      ));
}