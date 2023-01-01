import 'package:flutter/material.dart';
import 'package:gpay_clone/constants/colors.dart';
import 'package:gpay_clone/widgets/number_key.dart';

class UPIKeypad extends StatelessWidget {
  const UPIKeypad({
    required this.append,
    required this.prepend,
    required this.submit,
    Key? key,
  }) : super(key: key);

  final Function append;
  final Function prepend;
  final Function submit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      alignment: Alignment.center,
      color: ApplicationColors.darkGrey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              child: Row(
            children: [
              NumberKey(num: 1, appendKeyToList: append),
              NumberKey(num: 2, appendKeyToList: append),
              NumberKey(num: 3, appendKeyToList: append),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              NumberKey(num: 4, appendKeyToList: append),
              NumberKey(num: 5, appendKeyToList: append),
              NumberKey(num: 6, appendKeyToList: append),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              NumberKey(num: 7, appendKeyToList: append),
              NumberKey(num: 8, appendKeyToList: append),
              NumberKey(num: 9, appendKeyToList: append),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              BackspaceKey(backspace: prepend),
              NumberKey(num: 0, appendKeyToList: append),
              SubmitKey(submit: submit)
            ],
          )),
        ],
      ),
    ));
  }
}
