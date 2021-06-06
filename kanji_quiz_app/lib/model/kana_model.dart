import 'package:flutter/foundation.dart';

class Kana {
  final String type;
  final String reading;
  final String characterLook;

  Kana({
    @required this.type,
    @required this.reading,
    @required this.characterLook,
  });
}

List<Kana> kanjiStaticData = [
  Kana(
    reading: "a",
    type: "Hiragana",
    characterLook: "あ",
  ),
  Kana(
    reading: "i",
    type: "Hiragana",
    characterLook: "い",
  ),
  Kana(
    reading: "u",
    type: "Hiragana",
    characterLook: "う",
  ),
  Kana(
    reading: "e",
    type: "Hiragana",
    characterLook: "え",
  ),
  Kana(
    reading: "o",
    type: "Hiragana",
    characterLook: "お",
  ),
  Kana(
    reading: "ka",
    type: "Hiragana",
    characterLook: "か",
  ),
  Kana(
    reading: "ki",
    type: "Hiragana",
    characterLook: "き",
  ),
  Kana(
    reading: "ku",
    type: "Hiragana",
    characterLook: "く",
  ),
  Kana(
    reading: "ke",
    type: "Hiragana",
    characterLook: "け",
  ),
  Kana(
    reading: "ko",
    type: "Hiragana",
    characterLook: "こ",
  ),
  Kana(
    reading: "sa",
    type: "Hiragana",
    characterLook: "さ",
  ),
  Kana(
    reading: "shi",
    type: "Hiragana",
    characterLook: "し",
  ),
  Kana(
    reading: "su",
    type: "Hiragana",
    characterLook: "す",
  ),
  Kana(
    reading: "se",
    type: "Hiragana",
    characterLook: "せ",
  ),
  Kana(
    reading: "so",
    type: "Hiragana",
    characterLook: "そ",
  ),
  Kana(
    reading: "ta",
    type: "Hiragana",
    characterLook: "た",
  ),
  Kana(
    reading: "chi",
    type: "Hiragana",
    characterLook: "ち",
  ),
  Kana(
    reading: "tsu",
    type: "Hiragana",
    characterLook: "つ",
  ),
  Kana(
    reading: "te",
    type: "Hiragana",
    characterLook: "て",
  ),
  Kana(
    reading: "to",
    type: "Hiragana",
    characterLook: "と",
  ),
  Kana(
    reading: "na",
    type: "Hiragana",
    characterLook: "な",
  ),
  Kana(
    reading: "ni",
    type: "Hiragana",
    characterLook: "に",
  ),
  Kana(
    reading: "nu",
    type: "Hiragana",
    characterLook: "ぬ",
  ),
  Kana(
    reading: "ne",
    type: "Hiragana",
    characterLook: "ね",
  ),
  Kana(
    reading: "no",
    type: "Hiragana",
    characterLook: "の",
  ),
  Kana(
    reading: "ha",
    type: "Hiragana",
    characterLook: "は",
  ),
  Kana(
    reading: "hi",
    type: "Hiragana",
    characterLook: "ひ",
  ),
  Kana(
    reading: "fu",
    type: "Hiragana",
    characterLook: "ふ",
  ),
  Kana(
    reading: "he",
    type: "Hiragana",
    characterLook: "へ",
  ),
  Kana(
    reading: "ho",
    type: "Hiragana",
    characterLook: "ほ",
  ),
  Kana(
    reading: "ma",
    type: "Hiragana",
    characterLook: "ま",
  ),
  Kana(
    reading: "mi",
    type: "Hiragana",
    characterLook: "み",
  ),
  Kana(
    reading: "mu",
    type: "Hiragana",
    characterLook: "む",
  ),
  Kana(
    reading: "me",
    type: "Hiragana",
    characterLook: "め",
  ),
  Kana(
    reading: "mo",
    type: "Hiragana",
    characterLook: "も",
  ),
  Kana(
    reading: "ya",
    type: "Hiragana",
    characterLook: "や",
  ),
  Kana(
    reading: "yu",
    type: "Hiragana",
    characterLook: "ゆ",
  ),
  Kana(
    reading: "yo",
    type: "Hiragana",
    characterLook: "よ",
  ),
  Kana(
    reading: "ra",
    type: "Hiragana",
    characterLook: "ら",
  ),
  Kana(
    reading: "ri",
    type: "Hiragana",
    characterLook: "り",
  ),
  Kana(
    reading: "ru",
    type: "Hiragana",
    characterLook: "る",
  ),
  Kana(
    reading: "re",
    type: "Hiragana",
    characterLook: "れ",
  ),
  Kana(
    reading: "ro",
    type: "Hiragana",
    characterLook: "ろ",
  ),
  Kana(
    reading: "wa",
    type: "Hiragana",
    characterLook: "わ",
  ),
  Kana(
    reading: "o (wo)",
    type: "Hiragana",
    characterLook: "を",
  ),
  Kana(
    reading: "n",
    type: "Hiragana",
    characterLook: "ん",
  ),
  Kana(
    reading: "ga",
    type: "Hiragana",
    characterLook: "が",
  ),
  Kana(
    reading: "gi",
    type: "Hiragana",
    characterLook: "ぎ",
  ),
  Kana(
    reading: "gu",
    type: "Hiragana",
    characterLook: "ぐ",
  ),
  Kana(
    reading: "ge",
    type: "Hiragana",
    characterLook: "げ",
  ),
  Kana(
    reading: "go",
    type: "Hiragana",
    characterLook: "ご",
  ),
  Kana(
    reading: "za",
    type: "Hiragana",
    characterLook: "ざ",
  ),
  Kana(
    reading: "ji (zi)",
    type: "Hiragana",
    characterLook: "じ",
  ),
  Kana(
    reading: "zu",
    type: "Hiragana",
    characterLook: "ず",
  ),
  Kana(
    reading: "ze",
    type: "Hiragana",
    characterLook: "ぜ",
  ),
  Kana(
    reading: "zo",
    type: "Hiragana",
    characterLook: "ぞ",
  ),
  Kana(
    reading: "da",
    type: "Hiragana",
    characterLook: "だ",
  ),
  Kana(
    reading: "ji (di)",
    type: "Hiragana",
    characterLook: "ぢ",
  ),
  Kana(
    reading: "zu (du)",
    type: "Hiragana",
    characterLook: "づ",
  ),
  Kana(
    reading: "de",
    type: "Hiragana",
    characterLook: "で",
  ),
  Kana(
    reading: "do",
    type: "Hiragana",
    characterLook: "ど",
  ),
  Kana(
    reading: "ba",
    type: "Hiragana",
    characterLook: "ば",
  ),
  Kana(
    reading: "bi",
    type: "Hiragana",
    characterLook: "び",
  ),
  Kana(
    reading: "bu",
    type: "Hiragana",
    characterLook: "ぶ",
  ),
  Kana(
    reading: "be",
    type: "Hiragana",
    characterLook: "べ",
  ),
  Kana(
    reading: "bo",
    type: "Hiragana",
    characterLook: "ぼ",
  ),
  Kana(
    reading: "pa",
    type: "Hiragana",
    characterLook: "ぱ",
  ),
  Kana(
    reading: "pi",
    type: "Hiragana",
    characterLook: "ぴ",
  ),
  Kana(
    reading: "pu",
    type: "Hiragana",
    characterLook: "ぷ",
  ),
  Kana(
    reading: "pe",
    type: "Hiragana",
    characterLook: "ぺ",
  ),
  Kana(
    reading: "po",
    type: "Hiragana",
    characterLook: "ぽ",
  ),
  Kana(
    reading: "kya",
    type: "Hiragana",
    characterLook: "きゃ",
  ),
  Kana(
    reading: "kyu",
    type: "Hiragana",
    characterLook: "きゅ",
  ),
  Kana(
    reading: "kyo",
    type: "Hiragana",
    characterLook: "きょ",
  ),
  Kana(
    reading: "sha",
    type: "Hiragana",
    characterLook: "しゃ",
  ),
  Kana(
    reading: "shu",
    type: "Hiragana",
    characterLook: "しゅ",
  ),
  Kana(
    reading: "sho",
    type: "Hiragana",
    characterLook: "しょ",
  ),
  Kana(
    reading: "cha",
    type: "Hiragana",
    characterLook: "ちゃ",
  ),
  Kana(
    reading: "chu",
    type: "Hiragana",
    characterLook: "ちゅ",
  ),
  Kana(
    reading: "cho",
    type: "Hiragana",
    characterLook: "ちょ",
  ),
  Kana(
    reading: "nya",
    type: "Hiragana",
    characterLook: "にゃ",
  ),
  Kana(
    reading: "nyu",
    type: "Hiragana",
    characterLook: "にゅ",
  ),
  Kana(
    reading: "nyo",
    type: "Hiragana",
    characterLook: "にょ",
  ),
  Kana(
    reading: "hya",
    type: "Hiragana",
    characterLook: "ひゃ",
  ),
  Kana(
    reading: "hyu",
    type: "Hiragana",
    characterLook: "ひゅ",
  ),
  Kana(
    reading: "hyo",
    type: "Hiragana",
    characterLook: "ひょ",
  ),
  Kana(
    reading: "mya",
    type: "Hiragana",
    characterLook: "みゃ",
  ),
  Kana(
    reading: "myu",
    type: "Hiragana",
    characterLook: "みゅ",
  ),
  Kana(
    reading: "myo",
    type: "Hiragana",
    characterLook: "みょ",
  ),
  Kana(
    reading: "rya",
    type: "Hiragana",
    characterLook: "りゃ",
  ),
  Kana(
    reading: "ryu",
    type: "Hiragana",
    characterLook: "りゅ",
  ),
  Kana(
    reading: "ryo",
    type: "Hiragana",
    characterLook: "りょ",
  ),
  Kana(
    reading: "gya",
    type: "Hiragana",
    characterLook: "ぎゃ",
  ),
  Kana(
    reading: "gyu",
    type: "Hiragana",
    characterLook: "ぎゅ",
  ),
  Kana(
    reading: "gyo",
    type: "Hiragana",
    characterLook: "ぎょ",
  ),
  Kana(
    reading: "ja",
    type: "Hiragana",
    characterLook: "じゃ",
  ),
  Kana(
    reading: "ju",
    type: "Hiragana",
    characterLook: "じゅ",
  ),
  Kana(
    reading: "jo",
    type: "Hiragana",
    characterLook: "じょ",
  ),
  Kana(
    reading: "bya",
    type: "Hiragana",
    characterLook: "びゃ",
  ),
  Kana(
    reading: "byu",
    type: "Hiragana",
    characterLook: "びゅ",
  ),
  Kana(
    reading: "byo",
    type: "Hiragana",
    characterLook: "びょ",
  ),
  Kana(
    reading: "pya",
    type: "Hiragana",
    characterLook: "ぴゃ",
  ),
  Kana(
    reading: "pyu",
    type: "Hiragana",
    characterLook: "ぴゅ",
  ),
  Kana(
    reading: "pyo",
    type: "Hiragana",
    characterLook: "ぴょ",
  ),
  Kana(
    reading: "a",
    type: "Katakana",
    characterLook: "ア",
  ),
  Kana(
    reading: "i",
    type: "Katakana",
    characterLook: "イ",
  ),
  Kana(
    reading: "u",
    type: "Katakana",
    characterLook: "ウ",
  ),
  Kana(
    reading: "e",
    type: "Katakana",
    characterLook: "エ",
  ),
  Kana(
    reading: "o",
    type: "Katakana",
    characterLook: "オ",
  ),
  Kana(
    reading: "ka",
    type: "Katakana",
    characterLook: "カ",
  ),
  Kana(
    reading: "ki",
    type: "Katakana",
    characterLook: "キ",
  ),
  Kana(
    reading: "ku",
    type: "Katakana",
    characterLook: "ク",
  ),
  Kana(
    reading: "ke",
    type: "Katakana",
    characterLook: "ケ",
  ),
  Kana(
    reading: "ko",
    type: "Katakana",
    characterLook: "コ",
  ),
  Kana(
    reading: "sa",
    type: "Katakana",
    characterLook: "サ",
  ),
  Kana(
    reading: "shi",
    type: "Katakana",
    characterLook: "シ",
  ),
  Kana(
    reading: "su",
    type: "Katakana",
    characterLook: "ス",
  ),
  Kana(
    reading: "se",
    type: "Katakana",
    characterLook: "セ",
  ),
  Kana(
    reading: "so",
    type: "Katakana",
    characterLook: "ソ",
  ),
  Kana(
    reading: "ta",
    type: "Katakana",
    characterLook: "タ",
  ),
  Kana(
    reading: "chi",
    type: "Katakana",
    characterLook: "チ",
  ),
  Kana(
    reading: "tsu",
    type: "Katakana",
    characterLook: "ツ",
  ),
  Kana(
    reading: "te",
    type: "Katakana",
    characterLook: "テ",
  ),
  Kana(
    reading: "to",
    type: "Katakana",
    characterLook: "ト",
  ),
  Kana(
    reading: "na",
    type: "Katakana",
    characterLook: "ナ",
  ),
  Kana(
    reading: "ni",
    type: "Katakana",
    characterLook: "ニ",
  ),
  Kana(
    reading: "nu",
    type: "Katakana",
    characterLook: "ヌ",
  ),
  Kana(
    reading: "ne",
    type: "Katakana",
    characterLook: "ネ",
  ),
  Kana(
    reading: "no",
    type: "Katakana",
    characterLook: "ノ",
  ),
  Kana(
    reading: "ha",
    type: "Katakana",
    characterLook: "ハ",
  ),
  Kana(
    reading: "hi",
    type: "Katakana",
    characterLook: "ヒ",
  ),
  Kana(
    reading: "fu",
    type: "Katakana",
    characterLook: "フ",
  ),
  Kana(
    reading: "he",
    type: "Katakana",
    characterLook: "ヘ",
  ),
  Kana(
    reading: "ho",
    type: "Katakana",
    characterLook: "ホ",
  ),
  Kana(
    reading: "ma",
    type: "Katakana",
    characterLook: "マ",
  ),
  Kana(
    reading: "mi",
    type: "Katakana",
    characterLook: "ミ",
  ),
  Kana(
    reading: "mu",
    type: "Katakana",
    characterLook: "ム",
  ),
  Kana(
    reading: "me",
    type: "Katakana",
    characterLook: "メ",
  ),
  Kana(
    reading: "mo",
    type: "Katakana",
    characterLook: "モ",
  ),
  Kana(
    reading: "ya",
    type: "Katakana",
    characterLook: "ヤ",
  ),
  Kana(
    reading: "yu",
    type: "Katakana",
    characterLook: "ユ",
  ),
  Kana(
    reading: "yo",
    type: "Katakana",
    characterLook: "ヨ",
  ),
  Kana(
    reading: "ra",
    type: "Katakana",
    characterLook: "ラ",
  ),
  Kana(
    reading: "ri",
    type: "Katakana",
    characterLook: "リ",
  ),
  Kana(
    reading: "ru",
    type: "Katakana",
    characterLook: "ル",
  ),
  Kana(
    reading: "re",
    type: "Katakana",
    characterLook: "レ",
  ),
  Kana(
    reading: "ro",
    type: "Katakana",
    characterLook: "ロ",
  ),
  Kana(
    reading: "wa",
    type: "Katakana",
    characterLook: "ワ",
  ),
  Kana(
    reading: "o (wo)",
    type: "Katakana",
    characterLook: "ヲ",
  ),
  Kana(
    reading: "n",
    type: "Katakana",
    characterLook: "ン",
  ),
  Kana(
    reading: "ga",
    type: "Katakana",
    characterLook: "ガ",
  ),
  Kana(
    reading: "gi",
    type: "Katakana",
    characterLook: "ギ",
  ),
  Kana(
    reading: "gu",
    type: "Katakana",
    characterLook: "グ",
  ),
  Kana(
    reading: "ge",
    type: "Katakana",
    characterLook: "ゲ",
  ),
  Kana(
    reading: "go",
    type: "Katakana",
    characterLook: "ゴ",
  ),
  Kana(
    reading: "za",
    type: "Katakana",
    characterLook: "ザ",
  ),
  Kana(
    reading: "ji (zi)",
    type: "Katakana",
    characterLook: "ジ",
  ),
  Kana(
    reading: "zu",
    type: "Katakana",
    characterLook: "ズ",
  ),
  Kana(
    reading: "ze",
    type: "Katakana",
    characterLook: "ゼ",
  ),
  Kana(
    reading: "zo",
    type: "Katakana",
    characterLook: "ゾ",
  ),
  Kana(
    reading: "da",
    type: "Katakana",
    characterLook: "ダ",
  ),
  Kana(
    reading: "ji (di)",
    type: "Katakana",
    characterLook: "ヂ",
  ),
  Kana(
    reading: "zu (du)",
    type: "Katakana",
    characterLook: "ヅ",
  ),
  Kana(
    reading: "de",
    type: "Katakana",
    characterLook: "デ",
  ),
  Kana(
    reading: "do",
    type: "Katakana",
    characterLook: "ド",
  ),
  Kana(
    reading: "ba",
    type: "Katakana",
    characterLook: "バ",
  ),
  Kana(
    reading: "bi",
    type: "Katakana",
    characterLook: "ビ",
  ),
  Kana(
    reading: "bu",
    type: "Katakana",
    characterLook: "ブ",
  ),
  Kana(
    reading: "be",
    type: "Katakana",
    characterLook: "ベ",
  ),
  Kana(
    reading: "bo",
    type: "Katakana",
    characterLook: "ボ",
  ),
  Kana(
    reading: "pa",
    type: "Katakana",
    characterLook: "パ",
  ),
  Kana(
    reading: "pi",
    type: "Katakana",
    characterLook: "ピ",
  ),
  Kana(
    reading: "pu",
    type: "Katakana",
    characterLook: "プ",
  ),
  Kana(
    reading: "pe",
    type: "Katakana",
    characterLook: "ペ",
  ),
  Kana(
    reading: "po",
    type: "Katakana",
    characterLook: "ポ",
  ),
  Kana(
    reading: "kya",
    type: "Katakana",
    characterLook: "キャ",
  ),
  Kana(
    reading: "kyu",
    type: "Katakana",
    characterLook: "キュ",
  ),
  Kana(
    reading: "kyo",
    type: "Katakana",
    characterLook: "キョ",
  ),
  Kana(
    reading: "sha",
    type: "Katakana",
    characterLook: "シャ",
  ),
  Kana(
    reading: "shu",
    type: "Katakana",
    characterLook: "シュ",
  ),
  Kana(
    reading: "sho",
    type: "Katakana",
    characterLook: "ショ",
  ),
  Kana(
    reading: "cha",
    type: "Katakana",
    characterLook: "チャ",
  ),
  Kana(
    reading: "chu",
    type: "Katakana",
    characterLook: "チュ",
  ),
  Kana(
    reading: "cho",
    type: "Katakana",
    characterLook: "チョ",
  ),
  Kana(
    reading: "nya",
    type: "Katakana",
    characterLook: "ニャ",
  ),
  Kana(
    reading: "nyu",
    type: "Katakana",
    characterLook: "ニュ",
  ),
  Kana(
    reading: "nyo",
    type: "Katakana",
    characterLook: "ニョ",
  ),
  Kana(
    reading: "hya",
    type: "Katakana",
    characterLook: "ヒャ",
  ),
  Kana(
    reading: "hyu",
    type: "Katakana",
    characterLook: "ヒュ",
  ),
  Kana(
    reading: "hyo",
    type: "Katakana",
    characterLook: "ヒョ",
  ),
  Kana(
    reading: "mya",
    type: "Katakana",
    characterLook: "ミャ",
  ),
  Kana(
    reading: "myu",
    type: "Katakana",
    characterLook: "ミュ",
  ),
  Kana(
    reading: "myo",
    type: "Katakana",
    characterLook: "ミョ",
  ),
  Kana(
    reading: "rya",
    type: "Katakana",
    characterLook: "リャ",
  ),
  Kana(
    reading: "ryu",
    type: "Katakana",
    characterLook: "リュ",
  ),
  Kana(
    reading: "ryo",
    type: "Katakana",
    characterLook: "リョ",
  ),
  Kana(
    reading: "gya",
    type: "Katakana",
    characterLook: "ギャ",
  ),
  Kana(
    reading: "gyu",
    type: "Katakana",
    characterLook: "ギュ",
  ),
  Kana(
    reading: "gyo",
    type: "Katakana",
    characterLook: "ギョ",
  ),
  Kana(
    reading: "ja",
    type: "Katakana",
    characterLook: "ジャ",
  ),
  Kana(
    reading: "ju",
    type: "Katakana",
    characterLook: "ジュ",
  ),
  Kana(
    reading: "jo",
    type: "Katakana",
    characterLook: "ジョ",
  ),
  Kana(
    reading: "bya",
    type: "Katakana",
    characterLook: "ビャ",
  ),
  Kana(
    reading: "byu",
    type: "Katakana",
    characterLook: "ビュ",
  ),
  Kana(
    reading: "byo",
    type: "Katakana",
    characterLook: "ビョ",
  ),
  Kana(
    reading: "pya",
    type: "Katakana",
    characterLook: "ピャ",
  ),
  Kana(
    reading: "pyu",
    type: "Katakana",
    characterLook: "ピュ",
  ),
  Kana(
    reading: "pyo",
    type: "Katakana",
    characterLook: "ピョ",
  ),
];
