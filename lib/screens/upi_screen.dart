import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gpay_clone/constants/colors.dart';
import 'package:gpay_clone/constants/fonts.dart';
import 'package:gpay_clone/constants/textstyles.dart';
import 'package:gpay_clone/cubit/payment_cubit/payment_cubit.dart';
import 'package:gpay_clone/models/payment_model.dart';
import 'package:gpay_clone/screens/confirmation_screen.dart';
import 'package:gpay_clone/services/navigation_helper.dart';
import 'package:gpay_clone/widgets/appbar/upi_screen_appbar.dart';
import 'package:gpay_clone/widgets/upi_keypad.dart';

class UPIScreen extends StatefulWidget {
  const UPIScreen({Key? key}) : super(key: key);

  @override
  State<UPIScreen> createState() => _UPIScreenState();
}

class _UPIScreenState extends State<UPIScreen> {
  // Specify length of UPI Pin here
  int maxPinLength = 4;
  bool obscure = true;
  final List<int> _pinCodeList = [];
  Payment? payment;

  @override
  void initState() {
    super.initState();
    var paymentProvider = BlocProvider.of<PaymentCubit>(context, listen: false);
    payment = paymentProvider.payment;
  }

  List<Widget> getPinCodeFields() {
    List<Widget> pinCodeFields = [];
    for (int i = 0; i < maxPinLength; i++) {
      // if code exists, show number or obscured value
      if ((_pinCodeList.length - 1) >= i) {
        pinCodeFields.add(Expanded(
          child: Container(
            height: 54.0,
            alignment: Alignment.center,
            child: Text(obscure ? '\u2022' : _pinCodeList[i].toString(),
                style: TextStyles.keyStyle),
          ),
        ));
      }
      // else show blank
      else {
        pinCodeFields.add(Expanded(
          child: Container(
            height: 54.0,
            decoration: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                    bottom: BorderSide(
                        width: 2.0,
                        color: ApplicationColors.primaryColorDark))),
          ),
        ));
      }
      if (i != maxPinLength - 1) {
        pinCodeFields.add(const SizedBox(width: 8.0));
      }
    }
    return pinCodeFields;
  }

  void _appendList(int num) {
    if (_pinCodeList.length < maxPinLength) {
      _pinCodeList.add(num);
      setState(() {});
    }
  }

  void _prependList() {
    if (_pinCodeList.isNotEmpty) {
      _pinCodeList.removeLast();
      setState(() {});
    }
  }

  void _submit() {
    if (_pinCodeList.length == maxPinLength) {
      NavigationHelper().pushAndRemoveU(context, const ConfirmationScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ApplicationColors.scaffoldGrey,
      appBar: const UPIScreenAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            color: ApplicationColors.primaryColorDark,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      '${payment?.recipientFirstName} ${payment?.recipientLastName}'),
                  Row(
                    children: [
                      Text('Rs. ${payment?.amount}.00'),
                      const SizedBox(width: 8.0),
                      const Icon(Icons.keyboard_arrow_down)
                    ],
                  )
                ]),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1),
            alignment: Alignment.center,
            color: ApplicationColors.scaffoldGrey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('ENTER UPI PIN',
                          style: TextStyles.bodyText.copyWith(
                              fontWeight: Weight.bold,
                              color: ApplicationColors.grey)),
                    ),
                    const Spacer(),
                    _pinCodeList.isNotEmpty
                        ? Row(children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                const Icon(
                                  Icons.remove_red_eye,
                                  color: ApplicationColors.primaryColorDark,
                                ),
                                obscure
                                    ? const SizedBox.shrink()
                                    : Transform.rotate(
                                        angle: 0.6,
                                        child: Text(
                                          '/',
                                          style: TextStyles.h1.copyWith(
                                              color: ApplicationColors
                                                  .primaryColorDark),
                                        ),
                                      )
                              ],
                            ),
                            const SizedBox(width: 8.0),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              child: Text(obscure ? 'SHOW' : 'HIDE',
                                  style: TextStyles.bodyText.copyWith(
                                      fontWeight: Weight.bold,
                                      color:
                                          ApplicationColors.primaryColorDark)),
                            )
                          ])
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 8.0),
                Row(children: getPinCodeFields()),
              ],
            ),
          )),
          UPIKeypad(
            append: _appendList,
            prepend: _prependList,
            submit: _submit,
          ),
        ],
      ),
    );
  }
}
