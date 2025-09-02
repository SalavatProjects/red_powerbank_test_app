abstract class PaymentRepository {
  // AUTH
  Future<void> ensureAccount();

  // PAYMENTS
  Future<String> getClientToken();
  Future<String> addPaymentMethod({required String paymentToken});
  Future<void> createSubscription({required String paymentToken});
  Future<String> rentPowerBank({required String cabinetId, required String connectionKey});
}