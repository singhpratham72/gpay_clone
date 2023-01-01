import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpay_clone/constants/colors.dart';
import 'package:gpay_clone/constants/fonts.dart';
import 'package:gpay_clone/constants/strings.dart';
import 'package:gpay_clone/cubit/payment_cubit/payment_cubit.dart';
import 'package:gpay_clone/models/payment_model.dart';
import 'package:gpay_clone/widgets/appbar/landing_screen_appbar.dart';
import 'package:gpay_clone/widgets/choose_account_bottom_sheet.dart';
import 'package:gpay_clone/widgets/custom_textfield.dart';
import 'package:gpay_clone/widgets/snackbar_alert.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _amountController = TextEditingController();
  Payment? payment;
  bool editing = true;

  @override
  void initState() {
    var paymentProvider = BlocProvider.of<PaymentCubit>(context, listen: false);
    payment = paymentProvider.payment;
    super.initState();
  }

  void _submitAmount() async {
    if (_amountController.value.text.isEmpty) {
      SnackbarAlert().basicSnackbar(
          context: context, message: 'Payment must be at least ₹1');
    } else {
      int amount = int.parse(_amountController.value.text.replaceAll(',', ''));
      FocusManager.instance.primaryFocus?.unfocus();
      payment?.updateAmount(amount);
      var paymentProvider =
          BlocProvider.of<PaymentCubit>(context, listen: false);
      paymentProvider.updatePayment(payment!);
      await Future.delayed(const Duration(milliseconds: 200));
      setState(() {
        editing = false;
      });
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        if (editing) {
          return true;
        } else {
          setState(() {
            editing = true;
          });
          _focusNode.requestFocus();
          return false;
        }
      },
      child: Scaffold(
        appBar: const LandingScreenAppBar(),
        floatingActionButton: editing
            ? FloatingActionButton(
                onPressed: () {
                  _submitAmount();
                },
                mini: true,
                backgroundColor: ApplicationColors.white,
                child: const Icon(
                  Icons.arrow_forward,
                  color: ApplicationColors.primaryColor,
                ),
              )
            : const SizedBox.shrink(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.white),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: NetworkImage(
                                StringConstants.anonymousUserImage1))),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 16.0,
                    ),
                  ),
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.0, color: Colors.white),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                            image: NetworkImage(
                                StringConstants.anonymousUserImage2))),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                  'Payment to ${payment?.recipientFirstName}\n(${payment?.recipientID})',
                  style: const TextStyle(fontWeight: Weight.heavy),
                  textAlign: TextAlign.center),
              const SizedBox(height: 44.0),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '₹',
                    style: TextStyle(fontSize: 32.0),
                  ),
                  const SizedBox(width: 4.0),
                  CustomTextField(
                    amountController: _amountController,
                    focusNode: _focusNode,
                    editing: editing,
                    onTap: () {
                      if (!editing) {
                        setState(() {
                          editing = true;
                        });
                      }
                    },
                    onChanged: (val) {
                      if (val.isNotEmpty) {
                        if (int.parse(val) == 0) {
                          _amountController.clear();
                        } else {
                          if (val.length <= 7) {
                            _amountController.text = _amountController.text
                                .replaceAllMapped(
                                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                    (Match m) => '${m[1]},');
                            _amountController.selection =
                                TextSelection.fromPosition(TextPosition(
                                    offset: _amountController.text.length));
                          }
                        }
                      }
                    },
                    onSubmitted: (_) {
                      _submitAmount();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              const Text('Payment via BillDesk'),
              const Spacer(),
              editing
                  ? const SizedBox.shrink()
                  : const ChooseAccountBottomSheet()
            ],
          ),
        ),
      ),
    );
  }
}
