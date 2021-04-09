import 'package:kanji_quiz_app/model/kanji_model.dart';

List<Kanji> kanjiStaticData = [
  Kanji(
    keyword: "Five",
    itemType: "Kanji",
    jlptLevel: "N5",
    frameNumber: 5,
    koohiiNumber: 5,
    characterLook: "五",
    buildingBlocksLook: [],
    buildingBlockKeywords: [],
    similarCharactersLook: ["吾", "悟"],
    similarCharactersKeyword: ["I", "Enlightenment"],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 71,
    kanjiMeanings: ["Five"],
  ),
  Kanji(
    keyword: "Ten",
    itemType: "Kanji",
    jlptLevel: "N5",
    frameNumber: 10,
    koohiiNumber: 10,
    characterLook: "十",
    buildingBlocksLook: [],
    buildingBlockKeywords: [],
    similarCharactersLook: ["干", "千"],
    similarCharactersKeyword: ["Dry", "Thousand"],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 32,
    kanjiMeanings: ["Ten"],
  ),
  Kanji(
    keyword: "Mouth",
    itemType: "Kanji",
    jlptLevel: "N4",
    frameNumber: 11,
    koohiiNumber: 11,
    characterLook: "口",
    buildingBlocksLook: [],
    buildingBlockKeywords: [],
    similarCharactersLook: ["回", "固"],
    similarCharactersKeyword: ["Times", "Harden"],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 89,
    kanjiMeanings: ["Mouth"],
  ),
  Kanji(
    keyword: "Sun",
    itemType: "Kanji",
    jlptLevel: "N5",
    frameNumber: 12,
    koohiiNumber: 12,
    characterLook: "日",
    buildingBlocksLook: [],
    buildingBlockKeywords: [],
    similarCharactersLook: ["旧", "旦"],
    similarCharactersKeyword: ["Old times", "Daybreak"],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 5,
    kanjiMeanings: ["day", "sun", "Japan", "counter for days"],
  ),
  Kanji(
    keyword: "Moon",
    itemType: "Kanji",
    jlptLevel: "N5",
    frameNumber: 13,
    koohiiNumber: 13,
    characterLook: "月",
    buildingBlocksLook: [],
    buildingBlockKeywords: [],
    similarCharactersLook: ["朋", "肌"],
    similarCharactersKeyword: ["Companion", "Texture"],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 47,
    kanjiMeanings: ["month", "moon"],
  ),
  Kanji(
    keyword: "Oneself",
    itemType: "Kanji",
    jlptLevel: "N5",
    frameNumber: 17,
    koohiiNumber: 17,
    characterLook: "吾",
    buildingBlocksLook: ["五", "口"],
    buildingBlockKeywords: ["Five", "Mouth"],
    similarCharactersLook: ["悟"],
    similarCharactersKeyword: ["Enlightenment"],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 553,
    kanjiMeanings: ["I", "my", "our", "one's own"],
  ),
  Kanji(
    keyword: "Bright",
    itemType: "Kanji",
    jlptLevel: "N3",
    frameNumber: 20,
    koohiiNumber: 20,
    characterLook: "明",
    buildingBlocksLook: ["日", "月"],
    buildingBlockKeywords: ["Sun", "Moon"],
    similarCharactersLook: ["胆", "脂"],
    similarCharactersKeyword: ["Gall bladder", "Fat"],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 72,
    kanjiMeanings: ["bright", "light"],
  ),
  Kanji(
    keyword: "Goods",
    itemType: "Kanji",
    jlptLevel: "N3",
    frameNumber: 23,
    koohiiNumber: 23,
    characterLook: "品",
    buildingBlocksLook: ["口"],
    buildingBlockKeywords: ["Mouth"],
    similarCharactersLook: [],
    similarCharactersKeyword: [],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 282,
    kanjiMeanings: ["goods", "refinement", "dignity", "article"],
  ),
  Kanji(
    keyword: "Top hat",
    itemType: "Radical",
    jlptLevel: "",
    frameNumber: 0,
    koohiiNumber: 20128,
    characterLook: "亠",
    buildingBlocksLook: [],
    buildingBlockKeywords: [],
    similarCharactersLook: [],
    similarCharactersKeyword: [],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 4759,
    kanjiMeanings: [],
  ),
  Kanji(
    keyword: "Garment",
    itemType: "Kanji",
    jlptLevel: "N2",
    frameNumber: 423,
    koohiiNumber: 423,
    characterLook: "衣",
    buildingBlocksLook: ["亠"],
    buildingBlockKeywords: ["Top hat"],
    similarCharactersLook: ["衰", "依"],
    similarCharactersKeyword: ["Decline", "Reliant"],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 627,
    kanjiMeanings: ["garment", "clothes", "dressing"],
  ),
  Kanji(
    keyword: "Pathetic",
    itemType: "Kanji",
    jlptLevel: "N1",
    frameNumber: 428,
    koohiiNumber: 428,
    characterLook: "哀",
    buildingBlocksLook: ["亠", "口", "衣"],
    buildingBlockKeywords: ["Top hat", "Mouth", "Garment"],
    similarCharactersLook: ["喪", "衰"],
    similarCharactersKeyword: ["Mourning", "Decline"],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 971,
    kanjiMeanings: [
      "pathetic",
      "grief",
      "sorrow",
      "pathos",
      "pity",
      "sympathize",
    ],
  ),
  Kanji(
    keyword: "Road",
    itemType: "Primitive",
    jlptLevel: "",
    frameNumber: 0,
    koohiiNumber: 0,
    characterLook: "assets/images/badge_295p_xl.png",
    buildingBlocksLook: [],
    buildingBlockKeywords: [],
    similarCharactersLook: [],
    similarCharactersKeyword: [],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 0,
    kanjiMeanings: [],
  ),
  Kanji(
    keyword: "Scarecrow",
    itemType: "Primitive",
    jlptLevel: "",
    frameNumber: 0,
    koohiiNumber: 0,
    characterLook: "assets/images/badge_1700p_xl.png",
    buildingBlocksLook: [],
    buildingBlockKeywords: [],
    similarCharactersLook: [],
    similarCharactersKeyword: [],
    dateLastLevelChanged: DateTime.now().subtract(Duration(days: 5)),
    frequencyInAozora: 0,
    kanjiMeanings: [],
  ),
];
