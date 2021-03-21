class Kanji {
  String keyword;
  String itemType;
  int frameNumber;
  int koohiiNumber;
  int progressLevel;
  String characterLook;
  String mnemonicStory;
  String learningStatus;
  List<String> buildingBlocksLook;
  List<String> buildingBlockKeywords;
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
    this.buildingBlocksLook,
    this.buildingBlockKeywords,
    this.dateLastLevelChanged,
  });

  factory Kanji.fromJson(Map<String, dynamic> json) {
    var jsonTempOne = json['buildingBlocksLook'];
    List<String> buildingBlocksList = jsonTempOne.cast<String>();

    var jsonTempTwo = json['buildingBlockKeywords'];
    List<String> buildingBlocksKeyList = jsonTempTwo.cast<String>();

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
      buildingBlocksLook: buildingBlocksList,
      buildingBlockKeywords: buildingBlocksKeyList,
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
      'buildingBlocksLook': this.buildingBlocksLook,
      'buildingBlockKeywords': this.buildingBlockKeywords,
      'dateLastLevelChanged': formatedDate,
    };
  }
}
