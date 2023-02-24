import 'package:fabrikod_quran/constants/constants.dart';
import 'package:fabrikod_quran/models/bookmark_model.dart';
import 'package:fabrikod_quran/models/mushaf_backgrund_model.dart';
import 'package:fabrikod_quran/models/verse_model.dart';
import 'package:fabrikod_quran/providers/bookmark_provider.dart';
import 'package:fabrikod_quran/providers/favorites_provider.dart';
import 'package:fabrikod_quran/providers/player_provider.dart';
import 'package:fabrikod_quran/providers/quran_provider.dart';
import 'package:fabrikod_quran/providers/surah_details_provider.dart';
import 'package:fabrikod_quran/widgets/basmala_title.dart';
import 'package:fabrikod_quran/widgets/buttons/verse_detail_settings_button.dart';
import 'package:fabrikod_quran/widgets/cards/mushaf_settings_card.dart';
import 'package:fabrikod_quran/widgets/cards/new_verse_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class TranslationScreen extends StatefulWidget {
  const TranslationScreen({Key? key}) : super(key: key);

  @override
  State<TranslationScreen> createState() => _TranslationScreenState();
}

class _TranslationScreenState extends State<TranslationScreen> {
  /// Scroll Controller for Verse List
  final ItemScrollController itemScrollController = ItemScrollController();

  /// Item position listener of Verse list
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      itemScrollController.jumpTo(
          index: context.read<SurahDetailsProvider>().jumpToVerseIndex);
      itemPositionsListener.itemPositions.addListener(scrollListener);
    });
  }

  /// Scroll Listener
  void scrollListener() {
    var first = itemPositionsListener.itemPositions.value.first.index;
    var last = itemPositionsListener.itemPositions.value.last.index;
    var index = first <= last ? first : last;
    context.read<SurahDetailsProvider>().listenToTranslationScreenList(index);
  }

  @override
  Widget build(BuildContext context) {
    var verses = context.watch<SurahDetailsProvider>().showedVerses;
    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: Visibility(
        visible:
            context.watch<SurahDetailsProvider>().readingSettings.isReadingMode,
        child: VerseDetailSettingsButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) => MushafSettingsCard());
          },
        ),
      ),
      body: InkWell(
        onTap: context.read<SurahDetailsProvider>().changeReadingMode,
        child: ScrollablePositionedList.separated(
          itemCount: verses.length,
          itemScrollController: itemScrollController,
          itemPositionsListener: itemPositionsListener,
          padding: const EdgeInsets.only(
            left: kSizeM,
            right: kSizeL,
            bottom: kSizeXL,
          ),
          physics: const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            final verse = verses[index];
            return Column(
              children: [
                BasmalaTitle(verseKey: verse.verseKey ?? ""),
                buildVerseCard(index, verse, context),
              ],
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: kSizeM),
        ),
      ),
    );
  }

  VerseCard buildVerseCard(int index, VerseModel verse, BuildContext context) {
    return VerseCard(
      verseModel: verse,
      arabicFontFamily: Fonts.uthmanic,
      verseTranslations: context
          .watch<QuranProvider>()
          .translationService
          .translationsOfVerse(verse.id!),
      readOptions: context.watch<QuranProvider>().localSetting.readOptions,
      textScaleFactor:
          context.watch<QuranProvider>().localSetting.textScaleFactor,
      translationFontFamily: Fonts.getTranslationFont(
          context.watch<QuranProvider>().localSetting.fontType),
      isPlaying:
          context.watch<PlayerProvider>().isPlayingVerse(verse.verseKey ?? ""),
      playFunction: (verse, isPlaying) {
        context.read<SurahDetailsProvider>().onTapVerseCardPlayOrPause(
              index,
              isPlaying,
              verse.verseKey ?? "",
            );
      },
      isFavorite: context.watch<FavoritesProvider>().isFavoriteVerse(verse),
      favoriteFunction: context.read<FavoritesProvider>().onTapFavoriteButton,
      isBookmark: context.watch<BookmarkProvider>().isBookmark(
            BookMarkModel(bookmarkType: EBookMarkType.verse, verseModel: verse),
          ),
      bookmarkFunction: context.read<BookmarkProvider>().onTapBookMarkButton,
      shareFunction: (verseModel) {},
    );
  }
}
