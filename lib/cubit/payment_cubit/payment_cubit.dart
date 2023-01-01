import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpay_clone/constants/strings.dart';
import 'package:gpay_clone/cubit/payment_cubit/payment_state.dart';
import 'package:gpay_clone/models/payment_model.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit()
      : super(LoadedState(Payment(
            recipientFirstName: StringConstants.firstName,
            recipientLastName: StringConstants.lastName,
            recipientID: StringConstants.upiID)));

  Future<void> updatePayment(Payment payment) async {
    emit(LoadedState(payment));
  }

  Payment? get payment => (state as LoadedState).payment;
}
