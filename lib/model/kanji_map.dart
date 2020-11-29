class KanjiMap {
  List<Map<String, String>> _initalMap = [
    {
      'keyword': 'Five',
      'frameNumber': '5',
      'learningStatus': 'Lesson',
      'photoAddress': 'assets/images/17_Kanji_xlg.png',
    },
    {
      'keyword': 'Mouth',
      'frameNumber': '11',
      'learningStatus': 'Review',
      'photoAddress': 'assets/images/18_Kanji_xlg.png',
    },
    {
      'keyword': 'Sun',
      'frameNumber': '12',
      'learningStatus': 'Lesson',
      'photoAddress': 'assets/images/19_Kanji_xlg.png',
    },
    {
      'keyword': 'Moon',
      'frameNumber': '13',
      'learningStatus': 'Review',
      'photoAddress': 'assets/images/19_Kanji_xlg.png',
    },
    // {
    //   'keyword': 'Oneself',
    //   'frameNumber': '17',
    //   'learningStatus': 'Review',
    //   'photoAddress': 'assets/images/17_Kanji_xlg.png',
    // },
    // {
    //   'keyword': 'Bright',
    //   'frameNumber': '20',
    //   'learningStatus': 'Review',
    //   'photoAddress': 'assets/images/18_Kanji_xlg.png',
    // },
    // {
    //   'keyword': 'Goods',
    //   'frameNumber': '23',
    //   'learningStatus': 'Review',
    //   'photoAddress': 'assets/images/19_Kanji_xlg.png',
    // },
  ];

  List<Map<String, String>> get initialKanjiMap {
    return _initalMap;
  }
}
