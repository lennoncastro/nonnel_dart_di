import 'dependency_id.dart';

class Dependency {
  Dependency({
    required this.dependencyID,
    this.isSingleton = false,
  });

  final DependencyID dependencyID;
  final bool isSingleton;
}
