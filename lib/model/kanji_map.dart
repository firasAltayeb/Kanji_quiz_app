class KanjiMap {
  List<Map<String, String>> _initalMap = [
    {
      'keyword': 'Five',
      'frameNumber': '5',
      'mnemonicStory': '',
      'learningStatus': 'Review',
      'greyPhotoAddress': 'assets/images/5_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/5_Kanji_xl.png',
      'buildingBlockOne': '',
      'buildingBlockTwo': ''
    },
    {
      'keyword': 'Mouth',
      'frameNumber': '11',
      'mnemonicStory': '',
      'learningStatus': 'Review',
      'greyPhotoAddress': 'assets/images/11_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/11_Kanji_xl.png',
      'buildingBlockOne': '',
      'buildingBlockTwo': ''
    },
    {
      'keyword': 'Sun',
      'frameNumber': '12',
      'mnemonicStory': '',
      'learningStatus': 'Review',
      'greyPhotoAddress': 'assets/images/12_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/12_Kanji_xl.png',
      'buildingBlockOne': '',
      'buildingBlockTwo': ''
    },
    {
      'keyword': 'Moon',
      'frameNumber': '13',
      'mnemonicStory': '',
      'learningStatus': 'Review',
      'greyPhotoAddress': 'assets/images/13_Kanji_xlg.png',
      'colorPhotoAddress': 'assets/images/13_Kanji_xl.png',
      'buildingBlockOne': '',
      'buildingBlockTwo': ''
    },
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
      'buildingBlockTwo': ''
    }
  ];

  List<Map<String, String>> get initialKanjiMap {
    return _initalMap;
  }
}
