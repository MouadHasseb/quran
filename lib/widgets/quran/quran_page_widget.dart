import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_open_quran/constants/constants.dart';

import '../../constants/enums.dart';
import '../../constants/padding.dart';
import '../../models/mushaf_backgrund_model.dart';
import '../../models/surah_model.dart';
import '../../models/verse_model.dart';
import '../../providers/quran_provider.dart';
import '../basmala_title.dart';

class QuranPageWidget extends StatelessWidget {
  const QuranPageWidget({
    Key? key,
    required this.versesOfPage,
    this.onTap,
    this.textScaleFactor = 1.0,
    this.isPlaying = false,
    required this.fontTypeArabic,
    required this.layoutOptions,
    required this.surahDetailsPageTheme,
    required this.playFunction,
  }) : super(key: key);

  final List<SurahModel> versesOfPage;
  final Function()? onTap;
  final double textScaleFactor;
  final String fontTypeArabic;
  final ELayoutOptions layoutOptions;
  final SurahDetailsPageThemeModel surahDetailsPageTheme;
  final bool isPlaying;
  final Function(VerseModel verseModel, bool isPlaying) playFunction;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          buildSurahCard(),
          const SizedBox(height: kSize3XL),
          buildBottomBorder(context, versesOfPage.last.verses.last)
        ],
      ),
    );
  }

  Widget buildSurahCard() {
    return ListView.builder(
      itemCount: versesOfPage.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final verses = versesOfPage.elementAt(index).verses;
        return Column(
          children: [
            BasmalaTitle(verseKey: verses.first.verseKey ?? ""),
            buildVersesText(context, verses, textScaleFactor, layoutOptions, fontTypeArabic),
          ],
        );
      },
    );
  }

  Widget buildVersesText(
    BuildContext context,
    List<VerseModel> verses,
    double textScaleFactor,
    ELayoutOptions layoutOptions,
    String fontTypeArabic,
  ) {
    return RichText(
      textDirection: TextDirection.rtl,
      textAlign: layoutOptions == ELayoutOptions.justify ? TextAlign.justify : TextAlign.right,
      textScaleFactor: textScaleFactor,
      text: TextSpan(
        style: context.theme.textTheme.headlineLarge?.copyWith(
            height: 2.4,
            fontFamily: Fonts.getArabicFont(fontTypeArabic),
            color: context.watch<QuranProvider>().surahDetailsPageThemeColor.textColor),
        children: verses
            .map(
              (e) => TextSpan(
                children: [
                  TextSpan(text: e.text!),
                  TextSpan(
                    text: Utils.getArabicVerseNo(e.verseNumber.toString()),
                    style: isPlaying
                        ? context.theme.textTheme.headlineLarge?.copyWith(
                            fontFamily: Fonts.uthmanicIcon,
                            fontSize: 27,
                            height: 0,
                            color: context.watch<QuranProvider>().surahDetailsPageThemeColor.textColor)
                        : context.theme.textTheme.displayMedium,
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildBottomBorder(BuildContext context, VerseModel verse) {
    return Container(
      padding: const EdgeInsets.only(bottom: kSizeS),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(color: surahDetailsPageTheme.transparentVectorColor),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${context.translate.juz} ${verse.juzNumber} | ${context.translate.hizb} ${verse.hizbNumber} - ${context.translate.page} ${verse.pageNumber}",
            style: context.theme.textTheme.bodySmall
                ?.copyWith(color: surahDetailsPageTheme.transparentTextColor, letterSpacing: 0.15),
          ),
          Text(
            verse.pageNumber?.quranPageNumber ?? "",
            style: context.theme.textTheme.bodyMedium
                ?.copyWith(color: surahDetailsPageTheme.transparentVectorColor, letterSpacing: 0.04),
          ),
        ],
      ),
    );
  }
}
