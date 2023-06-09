import 'dart:convert';

import 'package:collection/collection.dart';

class SettlementNamesData extends NamesData {
  SettlementNamesData(
      {required super.names,
      required super.imagePath,
      required super.description});
}

class NamesData {
  final List<String> names;
  final String imagePath;
  final String description;

  NamesData({
    required this.names,
    required this.imagePath,
    required this.description,
  });

  NamesData copyWith({
    List<String>? names,
    String? imagePath,
    String? description,
  }) {
    return NamesData(
      names: names ?? this.names,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'names': names,
      'imagePath': imagePath,
      'description': description,
    };
  }

  factory NamesData.fromMap(Map<String, dynamic> map) {
    return NamesData(
      names: List<String>.from((map['names'])),
      imagePath: map['imagePath'],
      description: map['description'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NamesData.fromJson(String source) =>
      NamesData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'NamesData(names: $names, imagePath: $imagePath, description: $description)';

  @override
  bool operator ==(covariant NamesData other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return listEquals(other.names, names) &&
        other.imagePath == imagePath &&
        other.description == description;
  }

  @override
  int get hashCode =>
      names.hashCode ^ imagePath.hashCode ^ description.hashCode;
}
