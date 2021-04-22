class Progress {
  String keyword;
  int progressLevel;
  String mnemonicStory;
  String learningStatus;
  DateTime dateLastLevelChanged;
  List<String> recallHistory;
  int chosenDifficulty;

  Progress({
    this.keyword,
    this.progressLevel,
    this.mnemonicStory,
    this.learningStatus,
    this.dateLastLevelChanged,
    this.recallHistory,
    this.chosenDifficulty,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    var jsonTempOne = json['recallHistory'];
    List<String> recallHistoryList = jsonTempOne.cast<String>();

    var jsonTempTwo = json['dateLastLevelChanged'];
    DateTime dateLastLevelChanged = jsonTempTwo == ''
        ? DateTime.now().subtract(Duration(days: 5))
        : DateTime.tryParse(json['dateLastLevelChanged']);

    return Progress(
      keyword: json['keyword'] as String,
      progressLevel: json['progressLevel'] as int,
      mnemonicStory: json['mnemonicStory'] as String,
      learningStatus: json['learningStatus'] as String,
      recallHistory: recallHistoryList,
      dateLastLevelChanged: dateLastLevelChanged,
      chosenDifficulty: json['chosenDifficulty'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    String formatedDate = this.dateLastLevelChanged.toIso8601String();

    return {
      'keyword': this.keyword,
      'progressLevel': this.progressLevel,
      'mnemonicStory': this.mnemonicStory,
      'learningStatus': this.learningStatus,
      'dateLastLevelChanged': formatedDate,
      'recallHistory': recallHistory,
      'chosenDifficulty': chosenDifficulty,
    };
  }
}
