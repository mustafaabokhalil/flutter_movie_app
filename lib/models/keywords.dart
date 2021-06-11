import 'dart:convert';

KeyWords keyWordsFromJson(String str) => KeyWords.fromJson(json.decode(str));

String keyWordsToJson(KeyWords data) => json.encode(data.toJson());

class KeyWords {
  KeyWords({
    this.id,
    this.keywords,
  });

  int? id;
  List<Keyword>? keywords;

  factory KeyWords.fromJson(Map<String, dynamic> json) => KeyWords(
        id: json["id"] == null ? null : json["id"],
        keywords: json["keywords"] == null
            ? null
            : List<Keyword>.from(
                json["keywords"].map((x) => Keyword.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "keywords": keywords == null
            ? null
            : List<dynamic>.from(keywords!.map((x) => x.toJson())),
      };
}

class Keyword {
  Keyword({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Keyword.fromJson(Map<String, dynamic> json) => Keyword(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
      };
}
