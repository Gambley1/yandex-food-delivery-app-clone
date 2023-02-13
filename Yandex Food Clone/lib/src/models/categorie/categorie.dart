import 'package:equatable/equatable.dart';

class Categorie extends Equatable {
  final String name;
  const Categorie({
    required this.name,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => <Object?>[
    name,
  ];
}
