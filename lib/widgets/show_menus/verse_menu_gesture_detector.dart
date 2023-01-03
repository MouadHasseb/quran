import 'package:fabrikod_quran/constants/constants.dart';
import 'package:flutter/material.dart';

import '../cards/verse_press_hold_button.dart';

class CustomGestureDetector extends StatefulWidget {
  const CustomGestureDetector(
      {Key? key, required this.child, required this.globalKey})
      : super(key: key);
  final Widget child;
  final GlobalKey globalKey;
  @override
  State<CustomGestureDetector> createState() => _CustomGestureDetectorState();
}

class _CustomGestureDetectorState extends State<CustomGestureDetector> {
  void _showContextMenu(
    BuildContext context,
    Function()? playFunction,
    Function()? favoriteFunction,
    Function()? bookmarkFunction,
    Function()? shareFunction,
  ) {
    RenderBox box =
        widget.globalKey.currentContext?.findRenderObject() as RenderBox;
    Offset position = box.localToGlobal(Offset.zero); //this is global position

    showMenu(
        context: context,
        color: AppColors.grey8,
        shape: RoundedRectangleBorder(
            side: BorderSide(
              color: AppColors.white.withOpacity(0.1),
            ),
            borderRadius: BorderRadius.circular(10)),
        // Show the context menu at the tap location
        position: RelativeRect.fromRect(
            Rect.fromLTWH(
                position.dx + kPaddingM, position.dy + kPaddingM, 0, 0),
            Rect.fromLTWH(
                0, 0, box.paintBounds.size.width, box.paintBounds.size.height)),

        // set a list of choices for the context menu
        items: [
          PopupMenuItem(
            onTap: playFunction,
            child: VersePressHoldMenuItem(
                iconPath: ImageConstants.play,
                buttonName: context.translate.play),
          ),
          PopupMenuItem(
            onTap: favoriteFunction,
            child: VersePressHoldMenuItem(
                iconPath: ImageConstants.favoriteInactiveIcon,
                buttonName: context.translate.favorite),
          ),
          PopupMenuItem(
            onTap: bookmarkFunction,
            child: VersePressHoldMenuItem(
                iconPath: ImageConstants.bookmarkInactiveIcon,
                buttonName: context.translate.bookmark),
          ),
          PopupMenuItem(
            onTap: shareFunction,
            child: VersePressHoldMenuItem(
                iconPath: ImageConstants.shareAppIcon,
                buttonName: context.translate.share),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showContextMenu(
          context,
          () {
            debugPrint('play');
          },
          () {
            debugPrint('favorite');
          },
          () {
            debugPrint('bookmark');
          },
          () {
            debugPrint('share');
          },
        );
      },
      child: widget.child,
    );
  }
}
