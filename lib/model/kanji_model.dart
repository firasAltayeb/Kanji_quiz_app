class Kanji {
  final String itemId;
  final String keyword;
  final String itemType;
  final int frameNumber;
  final int progressLevel;
  final String mnemonicStory;
  final String learningStatus;
  final List<String> buildingBlocks;
  final List<String> buildingBlockIds;
  final DateTime dateLastLevelChanged;

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
        : DateTime.parse(json['dateLastLevelChanged'].toString());

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
}
