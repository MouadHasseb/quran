import 'package:fabrikod_quran/constants/constants.dart';
import 'package:fabrikod_quran/widgets/app_bars/main_app_bar.dart';
import 'package:fabrikod_quran/widgets/cards/ayat_card.dart';
import 'package:flutter/material.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({super.key});

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(title: context.translate.bookmark),
      body: verseList,
    );
  }

  Widget get verseList {
    return ListView.separated(
        itemCount: 10,
        shrinkWrap: true,
        primary: false,
        padding: const EdgeInsets.symmetric(
            vertical: kPaddingVertical, horizontal: kPaddingHorizontal),
        itemBuilder: (context, index) => VerseCard(index: index),
        separatorBuilder: (context, index) =>
            const SizedBox(height: kPaddingHorizontal));
  }
}
