class Progress {
  String keyword;
  int progressLevel;
  String mnemonicStory;
  String learningStatus;
  DateTime dateLastLevelChanged;
  int incorrectReviewCounter;
  int chosenDifficulty;

  Progress({
    this.keyword,
    this.progressLevel,
    this.mnemonicStory,
    this.learningStatus,
    this.dateLastLevelChanged,
    this.incorrectReviewCounter,
    this.chosenDifficulty,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    var jsonTempThree = json['dateLastLevelChanged'];
    DateTime dateLastLevelChanged = jsonTempThree == ''
        ? DateTime.now().subtract(Duration(days: 5))
        : DateTime.tryParse(json['dateLastLevelChanged']);

    return Progress(
      keyword: json['keyword'] as String,
      progressLevel: json['progressLevel'] as int,
      mnemonicStory: json['mnemonicStory'] as String,
      learningStatus: json['learningStatus'] as String,
      dateLastLevelChanged: dateLastLevelChanged,
      incorrectReviewCounter: json['incorrectReviewCounter'] as int,
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
      'incorrectReviewCounter': incorrectReviewCounter,
      'chosenDifficulty': chosenDifficulty,
    };
  }
}
