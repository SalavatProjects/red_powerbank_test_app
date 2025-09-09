abstract class PaymentRepository {
  // AUTH
  Future<void> ensureAccount();

  // PAYMENTS
  Future<String> getClientToken();
  Future<String> updateClientToken();
  Future<String> addPaymentMethod({required String paymentToken, required String paymentType});
  Future<void> createSubscription({required String paymentToken, required String planId});
  Future<String> rentPowerBank({required String cabinetId, required String connectionKey});
}