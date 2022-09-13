class Dependency {
  Dependency({
    required this.builder,
    this.isSingleton = false,
  });

  final bool isSingleton;
  Object Function() builder;
}
