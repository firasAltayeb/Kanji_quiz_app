class Kanji {
  String keyword;
  String itemType;
  int frameNumber;
  int koohiiNumber;
  int progressLevel;
  String characterLook;
  String mnemonicStory;
  String learningStatus;
  List<String> buildingBlockKeywords;
  List<String> buildingBlockChatacters;
  DateTime dateLastLevelChanged;

  Kanji({
    this.keyword,
    this.itemType,
    this.frameNumber,
    this.koohiiNumber,
    this.characterLook,
    this.progressLevel,
    this.mnemonicStory,
    this.learningStatus,
    this.buildingBlockKeywords,
    this.buildingBlockChatacters,
    this.dateLastLevelChanged,
  });

  factory Kanji.fromJson(Map<String, dynamic> json) {
    var jsonTempOne = json['buildingBlockKeywords'];
    List<String> buildingBlocksKeyList = jsonTempOne.cast<String>();

    var jsonTempTwo = json['buildingBlockChatacters'];
    List<String> buildingBlockCharaList = jsonTempTwo.cast<String>();

    var jsonTempThree = json['dateLastLevelChanged'];
    DateTime dateLastLevelChanged = jsonTempThree == ''
        ? DateTime.now().subtract(Duration(days: 5))
        : DateTime.tryParse(json['dateLastLevelChanged']);

    return Kanji(
      keyword: json['keyword'] as String,
      itemType: json['itemType'] as String,
      frameNumber: json['frameNumber'] as int,
      koohiiNumber: json['koohiiNumber'] as int,
      progressLevel: json['progressLevel'] as int,
      characterLook: json['characterLook'] as String,
      mnemonicStory: json['mnemonicStory'] as String,
      learningStatus: json['learningStatus'] as String,
      buildingBlockKeywords: buildingBlocksKeyList,
      buildingBlockChatacters: buildingBlockCharaList,
      dateLastLevelChanged: dateLastLevelChanged,
    );
  }

  Map<String, dynamic> toJson() {
    String formatedDate = this.dateLastLevelChanged.toIso8601String();

    return {
      'keyword': this.keyword,
      'itemType': this.itemType,
      'frameNumber': this.frameNumber,
      'koohiiNumber': this.koohiiNumber,
      'progressLevel': this.progressLevel,
      'characterLook': this.characterLook,
      'mnemonicStory': this.mnemonicStory,
      'learningStatus': this.learningStatus,
      'buildingBlockKeywords': this.buildingBlockKeywords,
      'buildingBlockChatacters': this.buildingBlockChatacters,
      'dateLastLevelChanged': formatedDate,
    };
  }
}
