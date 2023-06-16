class Saveable {
  const Saveable({required this.fromJson, required this.toJson});

  final dynamic Function(String) fromJson;
  final String Function(dynamic) toJson;
}
