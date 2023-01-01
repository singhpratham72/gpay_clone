class Payment {
  final String recipientFirstName;
  final String recipientLastName;
  final String recipientID;
  int amount;

  Payment(
      {required this.recipientFirstName,
      required this.recipientLastName,
      required this.recipientID,
      this.amount = 0});

  updateAmount(int newAmount) {
    amount = newAmount;
  }
}
