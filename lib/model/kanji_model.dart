class Kanji {
  final String itemId;
  final String keyword;
  final String itemType;
  final int frameNumber;
  final int progressLevel;
  final String mnemonicStory;
  final String learningStatus;
  final List<String> buildingBlocks;

  Kanji({
    this.itemId,
    this.keyword,
    this.itemType,
    this.frameNumber,
    this.progressLevel,
    this.mnemonicStory,
    this.learningStatus,
    this.buildingBlocks,
  });

  factory Kanji.fromJson(Map<String, dynamic> json) {
    var buildingBlocks = json['buildingBlocks'];
    List<String> buildingBlocksList = buildingBlocks.cast<String>();

    return Kanji(
      itemId: json['itemId'] as String,
      keyword: json['keyword'] as String,
      itemType: json['itemType'] as String,
      frameNumber: json['frameNumber'] as int,
      progressLevel: json['progressLevel'] as int,
      mnemonicStory: json['mnemonicStory'] as String,
      learningStatus: json['learningStatus'] as String,
      buildingBlocks: buildingBlocksList,
    );
  }
}
