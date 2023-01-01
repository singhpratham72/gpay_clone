import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingScreenAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const LandingScreenAppBar({
    this.preferredSize = const Size.fromHeight(54.0),
    Key? key,
  }) : super(key: key);
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: GestureDetector(
        onTap: () {
          SystemNavigator.pop();
        },
        child: const Icon(Icons.arrow_back),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.more_vert),
        )
      ],
    );
  }
}
