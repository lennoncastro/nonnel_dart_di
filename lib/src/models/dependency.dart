class Dependency {
  Dependency({
    required this.builder,
    this.isSingleton = false,
  });

  factory Dependency.createDependency(
    Object Function() builder,
    bool isSingleton,
  ) =>
      Dependency(
        builder: builder,
        isSingleton: isSingleton,
      );

  final Object Function() builder;

  final bool isSingleton;
}
