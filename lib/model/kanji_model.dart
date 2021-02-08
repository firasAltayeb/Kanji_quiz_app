class Kanji {
  String itemId;
  String keyword;
  String itemType;
  int frameNumber;
  int progressLevel;
  String mnemonicStory;
  String learningStatus;
  List<String> buildingBlocks;
  List<String> buildingBlockIds;
  DateTime dateLastLevelChanged;

  Kanji({
    this.itemId,
    this.keyword,
    this.itemType,
    this.frameNumber,
    this.progressLevel,
    this.mnemonicStory,
    this.learningStatus,
    this.buildingBlocks,
    this.buildingBlockIds,
    this.dateLastLevelChanged,
  });

  factory Kanji.fromJson(Map<String, dynamic> json) {
    var jsonTempOne = json['buildingBlocks'];
    List<String> buildingBlocksList = jsonTempOne.cast<String>();

    var jsonTempTwo = json['buildingBlockIds'];
    List<String> buildingBlockIdList = jsonTempTwo.cast<String>();

    var jsonTempThree = json['dateLastLevelChanged'];
    DateTime dateLastLevelChanged = jsonTempThree == ''
        ? DateTime.now().subtract(Duration(days: 5))
        : DateTime.tryParse(json['dateLastLevelChanged']);

    return Kanji(
      itemId: json['itemId'] as String,
      keyword: json['keyword'] as String,
      itemType: json['itemType'] as String,
      frameNumber: json['frameNumber'] as int,
      progressLevel: json['progressLevel'] as int,
      mnemonicStory: json['mnemonicStory'] as String,
      learningStatus: json['learningStatus'] as String,
      buildingBlocks: buildingBlocksList,
      buildingBlockIds: buildingBlockIdList,
      dateLastLevelChanged: dateLastLevelChanged,
    );
  }

  Map<String, dynamic> toJson() {
    String formatedDate = this.dateLastLevelChanged.toIso8601String();

    return {
      'itemId': this.itemId,
      'keyword': this.keyword,
      'itemType': this.itemType,
      'frameNumber': this.frameNumber,
      'progressLevel': this.progressLevel,
      'mnemonicStory': this.mnemonicStory,
      'learningStatus': this.learningStatus,
      'buildingBlocks': this.buildingBlocks,
      'buildingBlockIds': this.buildingBlockIds,
      'dateLastLevelChanged': formatedDate,
    };
  }
}
