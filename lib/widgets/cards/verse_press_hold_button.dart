import 'package:fabrikod_quran/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VersePressHoldMenuItem extends StatelessWidget {
  const VersePressHoldMenuItem(
      {Key? key, required this.iconPath, required this.buttonName})
      : super(key: key);
  final String iconPath;
  final String buttonName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 45,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(iconPath,
                color: AppColors.grey4, width: kPaddingXL, height: kPaddingXL),
          ),
          const SizedBox(
            width: kPaddingL,
          ),
          Expanded(
            flex: 3,
            child: Text(
              buttonName,
              style: context.theme.textTheme.titleMedium
                  ?.copyWith(color: AppColors.grey2),
            ),
          )
        ],
      ),
    );
  }
}
