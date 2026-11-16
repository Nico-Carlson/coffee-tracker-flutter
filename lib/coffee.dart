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
}