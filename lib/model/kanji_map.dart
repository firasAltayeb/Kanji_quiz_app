class KanjiMap {
  List<Map<String, String>> _initalMap = [
    // {
    //   'keyword': 'Five',
    //   'frameNumber': '5',
    //   'learningStatus': 'Review',
    //   'photoAddress': 'assets/images/17_Kanji_xlg.png',
    // },
    // {
    //   'keyword': 'Mouth',
    //   'frameNumber': '11',
    //   'learningStatus': 'Review',
    //   'photoAddress': 'assets/images/18_Kanji_xlg.png',
    // },
    // {
    //   'keyword': 'Sun',
    //   'frameNumber': '12',
    //   'learningStatus': 'Review',
    //   'photoAddress': 'assets/images/19_Kanji_xlg.png',
    // },
    // {
    //   'keyword': 'Moon',
    //   'frameNumber': '13',
    //   'learningStatus': 'Review',
    //   'photoAddress': 'assets/images/19_Kanji_xlg.png',
    // },
    {
      'keyword': 'Oneself',
      'frameNumber': '17',
      'mnemonicStory': '',
      'learningStatus': 'Lesson',
      'greyPhotoAddress': 'assets/images/17_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/17_Kanji_xl.png',
      'buildingBlockOne': 'assets/images/5_Kanji_xl.png',
      'buildingBlockTwo': 'assets/images/11_Kanji_xl.png'
    },
    {
      'keyword': 'Bright',
      'frameNumber': '20',
      'mnemonicStory': '',
      'learningStatus': 'Lesson',
      'greyPhotoAddress': 'assets/images/18_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/18_Kanji_xl.png',
      'buildingBlockOne': 'assets/images/12_Kanji_xl.png',
      'buildingBlockTwo': 'assets/images/13_Kanji_xl.png'
    },
    {
      'keyword': 'Goods',
      'frameNumber': '23',
      'mnemonicStory': '',
      'learningStatus': 'Lesson',
      'greyPhotoAddress': 'assets/images/19_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/19_Kanji_xl.png',
      'buildingBlockOne': 'assets/images/11_Kanji_xl.png',
      'buildingBlockTwo': 'empty'
    }
  ];

  List<Map<String, String>> get initialKanjiMap {
    return _initalMap;
  }
}
