import '../errors/invalid_dependency_name.error.dart';

class DependencyID {
  DependencyID({
    this.typeName,
    this.named,
  }) {
    if (named != null && named!.isEmpty) {
      throw InvalidDependencyNameError();
    }
  }
  final String? typeName;
  final String? named;
}
