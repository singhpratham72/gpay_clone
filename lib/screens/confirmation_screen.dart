import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpay_clone/constants/colors.dart';
import 'package:gpay_clone/constants/fonts.dart';
import 'package:gpay_clone/constants/textstyles.dart';
import 'package:gpay_clone/cubit/payment_cubit/payment_cubit.dart';
import 'package:gpay_clone/models/payment_model.dart';
import 'package:gpay_clone/screens/landing_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  bool loading = true;
  Payment? payment;

  @override
  void initState() {
    super.initState();
    var paymentProvider = BlocProvider.of<PaymentCubit>(context, listen: false);
    payment = paymentProvider.payment;
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _success();
    });
  }

  void _success() async {
    await Future.delayed(const Duration(seconds: 3));
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        backgroundColor: ApplicationColors.white,
        body: Center(
          child: CircularProgressIndicator(
            color: ApplicationColors.primaryColor,
          ),
        ),
      );
    } else {
      return Scaffold(
        body: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadedScaleAnimation(
                child: const CircleAvatar(
                  radius: 42.0,
                  backgroundColor: ApplicationColors.white,
                  child: Icon(
                    Icons.check,
                    size: 48.0,
                    color: ApplicationColors.primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 54.0),
              Text(
                '₹ ${payment?.amount.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')} paid',
                style: TextStyles.h2,
              ),
              const SizedBox(height: 16.0),
              Text(
                  '${payment?.recipientFirstName} ${payment?.recipientLastName}',
                  style: const TextStyle(fontWeight: Weight.heavy)),
              Text(payment?.recipientID ?? ''),
              const SizedBox(height: 54.0),
              GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingScreen()),
                      (route) => false);
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        color: ApplicationColors.primaryColorLight,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: const Text(
                      'Done',
                      style: TextStyle(fontWeight: Weight.bold),
                    )),
              )
            ],
          ),
        ),
      );
    }
  }
}
