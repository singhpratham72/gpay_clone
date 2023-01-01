import 'package:flutter/material.dart';
import 'package:gpay_clone/constants/colors.dart';
import 'package:gpay_clone/constants/textstyles.dart';

class NumberKey extends StatelessWidget {
  const NumberKey({
    required this.num,
    required this.appendKeyToList,
    Key? key,
  }) : super(key: key);

  final int num;
  final Function appendKeyToList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            appendKeyToList(num);
          },
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: Text(num.toString(),
                style: TextStyles.keyStyle, textAlign: TextAlign.center),
          )),
    ));
  }
}

class BackspaceKey extends StatelessWidget {
  const BackspaceKey({
    required this.backspace,
    Key? key,
  }) : super(key: key);
  final Function backspace;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            backspace();
          },
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: const Icon(
              Icons.backspace,
              color: ApplicationColors.primaryColorDark,
            ),
          )),
    ));
  }
}

class SubmitKey extends StatelessWidget {
  const SubmitKey({
    required this.submit,
    Key? key,
  }) : super(key: key);
  final Function submit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            submit();
          },
          child: Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: const Icon(
              Icons.check_circle_rounded,
              size: 42.0,
              color: ApplicationColors.primaryColorDark,
            ),
          )),
    ));
  }
}
