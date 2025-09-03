import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_state.freezed.dart';

@freezed
class PaymentState with _$PaymentState{
  const factory PaymentState.initial() = _Initial;
  const factory PaymentState.processing() = _Processing;
  const factory PaymentState.success() = _Success;
  const factory PaymentState.error(String message) = _Error;
}
