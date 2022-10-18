import 'package:fabrikod_quran/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AyatCardButton extends StatelessWidget {
  const AyatCardButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);
  final Widget icon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 15,
        child: IconButton(
          padding: EdgeInsets.zero,
          onPressed: onTap,
          icon: icon,
        ));
  }
}
