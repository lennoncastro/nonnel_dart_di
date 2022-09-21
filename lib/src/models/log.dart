class Log {
  Log({
    required this.name,
    required this.type,
  });
  final String name;
  final String type;

  @override
  String toString() => 'type: $type, name: $name';
}
