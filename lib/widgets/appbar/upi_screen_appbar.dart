import 'package:flutter/material.dart';
import 'package:gpay_clone/constants/assets.dart';
import 'package:gpay_clone/constants/colors.dart';
import 'package:gpay_clone/constants/textstyles.dart';

class UPIScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const UPIScreenAppBar({
    this.preferredSize = const Size.fromHeight(54.0),
    Key? key,
  }) : super(key: key);
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ApplicationColors.darkGrey,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Text(
        'ICICI Bank',
        style: TextStyles.h3.copyWith(color: Colors.black),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Image.asset(
            Assets.upiLogo,
            width: 84.0,
          ),
        )
      ],
    );
  }
}
