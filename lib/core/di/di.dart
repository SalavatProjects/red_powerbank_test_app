import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:red_powerbank_test_app/core/network/dio_network.dart';
import 'package:red_powerbank_test_app/features/payment/data/payment_api.dart';
import 'package:red_powerbank_test_app/features/payment/domain/payment_repository.dart';
import 'package:red_powerbank_test_app/features/payment/data/payment_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> initDi() async {
  final dio = DioNetwork.createDio();

  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<PaymentApi>(() => PaymentApi(dio));
  getIt.registerLazySingleton<PaymentRepository>(() => PaymentRepositoryImpl(
        paymentApi: getIt<PaymentApi>(),
        dio: dio,
      ));
}