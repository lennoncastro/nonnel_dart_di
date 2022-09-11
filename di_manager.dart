import 'errors/not_declared_dependency.error.dart';

class DIManager {
  static final Map<String, Object Function()> _dependencies =
      <String, Object Function()>{};

  static void factory<T extends Object>(
    T instance, {
    String? named,
  }) {
    final Map<String, Object Function()> dependencie =
        <String, Object Function()>{
      named ?? T.toString(): () {
        return instance;
      }
    };

    _dependencies.addAll(dependencie);
  }

  static T inject<T extends Object>({
    String? named,
  }) {
    final String key = named ?? T.toString();

    final bool containsKey = _dependencies.containsKey(key);

    if (!containsKey) {
      throw NotDeclaredDependencyError(T.toString());
    }

    final Object Function() item = _dependencies.entries
        .where((element) => element.key == key)
        .first
        .value;

    return (item()) as T;
  }
}
