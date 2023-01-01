import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:gpay_clone/constants/assets.dart';
import 'package:gpay_clone/constants/colors.dart';
import 'package:gpay_clone/constants/fonts.dart';
import 'package:gpay_clone/screens/upi_screen.dart';
import 'package:gpay_clone/services/navigation_helper.dart';

class ChooseAccountBottomSheet extends StatelessWidget {
  const ChooseAccountBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadedSlideAnimation(
      beginOffset: const Offset(0, 1),
      endOffset: const Offset(0, 0),
      slideDuration: const Duration(milliseconds: 300),
      child: Container(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 24.0),
        decoration: const BoxDecoration(
            color: ApplicationColors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0))),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CHOOSE ACCOUNT TO PAY WITH',
              style: TextStyle(
                  fontSize: FontSize.S,
                  fontWeight: Weight.heavy,
                  color: ApplicationColors.grey,
                  overflow: TextOverflow.ellipsis),
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                Image.asset(
                  Assets.sbiLogo,
                  width: 60.0,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'State Bank of India \u2022\u2022\u2022\u20224321',
                          style: TextStyle(
                              fontSize: FontSize.S,
                              fontWeight: Weight.bold,
                              color: ApplicationColors.black,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          'Savings Account',
                          style: TextStyle(
                              fontSize: FontSize.S,
                              color: ApplicationColors.grey),
                        )
                      ]),
                ),
                const SizedBox(width: 8.0),
                const Icon(
                  Icons.keyboard_arrow_down,
                  color: ApplicationColors.grey,
                )
              ],
            ),
            GestureDetector(
              onTap: () {
                // Push to UPI Screen
                NavigationHelper().push(context, const UPIScreen());
              },
              child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 16.0),
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  decoration: BoxDecoration(
                      color: ApplicationColors.primaryColor,
                      borderRadius: BorderRadius.circular(24.0)),
                  child: const Text(
                    'Proceed to pay',
                    style: TextStyle(fontWeight: Weight.bold),
                  )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'IN PARTNERSHIP WITH',
                  style: TextStyle(
                      fontSize: FontSize.xXS, color: ApplicationColors.grey),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 2.0, left: 4.0),
                  child: Image.asset(
                    Assets.iciciLogo,
                    width: 60.0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
