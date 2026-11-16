import 'dart:convert';

class Coffee {
  final String id;
  final String name;
  final String roaster;
  final String roastLevel;
  final String process;
  final int brews;
  final String notes;

  Coffee({
    required this.id,
    required this.name,
    required this.roaster,
    required this.roastLevel,
    required this.process,
    this.brews = 0,
    required this.notes,
  });

  // Convert a Coffee object to a Map for JSON encoding
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'roaster': roaster,
      'roastLevel': roastLevel,
      'process': process,
      'brews': brews,
      'notes': notes,
    };
  }

  // Rebuild a Coffee object from a Map
  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
      id: map['id'],
      name: map['name'],
      roaster: map['roaster'],
      roastLevel: map['roastLevel'],
      process: map['process'],
      brews: map['brews'],
      notes: map['notes'],
    );
  }

  String toJson() => json.encode(toMap());
  factory Coffee.fromJson(String source) => Coffee.fromMap(json.decode(source));
}