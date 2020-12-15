class KanjiMap {
  List<Map<String, Object>> _initalMap = [
    {
      'keyword': 'Five',
      'frameNumber': '5',
      'mnemonicStory': '',
      'learningStatus': 'Review',
      'buildingBlocks': [],
      'greyPhotoAddress': 'assets/images/5_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/5_Kanji_xl.png',
      'buildBlocksAddress': [],
    },
    {
      'keyword': 'Mouth',
      'frameNumber': '11',
      'mnemonicStory': '',
      'learningStatus': 'Review',
      'buildingBlocks': [],
      'greyPhotoAddress': 'assets/images/11_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/11_Kanji_xl.png',
      'buildBlocksAddress': [],
    },
    {
      'keyword': 'Sun',
      'frameNumber': '12',
      'mnemonicStory': '',
      'learningStatus': 'Review',
      'buildingBlocks': [],
      'greyPhotoAddress': 'assets/images/12_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/12_Kanji_xl.png',
      'buildBlocksAddress': [],
    },
    {
      'keyword': 'Moon',
      'frameNumber': '13',
      'mnemonicStory': '',
      'learningStatus': 'Review',
      'buildingBlocks': [],
      'greyPhotoAddress': 'assets/images/13_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/13_Kanji_xl.png',
      'buildBlocksAddress': [],
    },
    {
      'keyword': 'Oneself',
      'frameNumber': '17',
      'mnemonicStory': '',
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
      'keyword': 'Bright',
      'frameNumber': '20',
      'mnemonicStory': '',
      'learningStatus': 'Lesson',
      'buildingBlocks': ['Sun, Moon'],
      'greyPhotoAddress': 'assets/images/18_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/18_Kanji_xl.png',
      'buildBlocksAddress': [
        'assets/images/12_Kanji_xl.png',
        'assets/images/13_Kanji_xl.png'
      ],
    },
    {
      'keyword': 'Goods',
      'frameNumber': '23',
      'mnemonicStory': '',
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
