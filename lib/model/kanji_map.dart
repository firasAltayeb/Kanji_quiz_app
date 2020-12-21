class KanjiMap {
  List<Map<String, Object>> _initalMap = [
    {
      'kanjiId': '五',
      'keyword': 'Five',
      'frameNumber': '5',
      'mnemonicStory': '',
      'progressLevel': 1,
      'learningStatus': 'Review',
      'buildingBlocks': [],
      'greyPhotoAddress': 'assets/images/5_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/5_Kanji_xl.png',
      'buildBlocksAddress': [],
    },
    {
      'kanjiId': '口',
      'keyword': 'Mouth',
      'frameNumber': '11',
      'mnemonicStory': '',
      'progressLevel': 1,
      'learningStatus': 'Review',
      'buildingBlocks': [],
      'greyPhotoAddress': 'assets/images/11_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/11_Kanji_xl.png',
      'buildBlocksAddress': [],
    },
    {
      'kanjiId': '日',
      'keyword': 'Sun',
      'frameNumber': '12',
      'mnemonicStory': '',
      'progressLevel': 1,
      'learningStatus': 'Review',
      'buildingBlocks': [],
      'greyPhotoAddress': 'assets/images/12_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/12_Kanji_xl.png',
      'buildBlocksAddress': [],
    },
    {
      'kanjiId': '月',
      'keyword': 'Moon',
      'frameNumber': '13',
      'mnemonicStory': '',
      'progressLevel': 1,
      'learningStatus': 'Review',
      'buildingBlocks': [],
      'greyPhotoAddress': 'assets/images/13_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/13_Kanji_xl.png',
      'buildBlocksAddress': [],
    },
    {
      'kanjiId': '吾',
      'keyword': 'Oneself',
      'frameNumber': '17',
      'mnemonicStory': '',
      'progressLevel': 1,
      'learningStatus': 'Lesson',
      'buildingBlocks': ['Five, Mouth'],
      'greyPhotoAddress': 'assets/images/17_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/17_Kanji_xl.png',
      'buildBlocksAddress': [
        'assets/images/5_Kanji_xl.png',
        'assets/images/11_Kanji_xl.png'
      ],
    },
    {
      'kanjiId': '明',
      'keyword': 'Bright',
      'frameNumber': '20',
      'mnemonicStory': '',
      'progressLevel': 1,
      'learningStatus': 'Lesson',
      'buildingBlocks': ['Sun, Moon'],
      'greyPhotoAddress': 'assets/images/18_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/18_Kanji_xl.png',
      'buildBlocksAddress': [
        'assets/images/12_Kanji_xl.png',
        'assets/images/12_Kanji_xl.png',
        'assets/images/13_Kanji_xl.png'
      ],
    },
    {
      'kanjiId': '品',
      'keyword': 'Goods',
      'frameNumber': '23',
      'mnemonicStory': '',
      'progressLevel': 1,
      'learningStatus': 'Lesson',
      'buildingBlocks': ['Mouth'],
      'greyPhotoAddress': 'assets/images/19_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/19_Kanji_xl.png',
      'buildBlocksAddress': ['assets/images/11_Kanji_xl.png'],
    }
  ];

  List<Map<String, Object>> get initialKanjiMap {
    return _initalMap;
  }
}
