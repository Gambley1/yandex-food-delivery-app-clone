// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Categorie {
  final String tag;
  Categorie({
    required this.tag,
  });

  String get getCategorieTag => tag;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tag': tag,
    };
  }

  factory Categorie.fromMap(Map<String, dynamic> json) {
    return Categorie(
      tag: json['tag'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Categorie.fromJson(Map<String, dynamic> json) => Categorie.fromMap(json);
}
