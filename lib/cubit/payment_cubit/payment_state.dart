import 'package:gpay_clone/models/payment_model.dart';

abstract class PaymentState {}

class LoadedState extends PaymentState {
  LoadedState(this.payment);

  final Payment payment;
  Object get props => payment;
}
