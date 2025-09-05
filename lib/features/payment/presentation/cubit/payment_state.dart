import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_state.freezed.dart';

@freezed
class PaymentState with _$PaymentState{
  const factory PaymentState.initial() = Initial;
  const factory PaymentState.processing() = Processing;
  const factory PaymentState.success() = Success;
  const factory PaymentState.error(String message) = Error;
}
