class DIManager {
  static final Map<String, Object Function()> _dependencies =
      <String, Object Function()>{};

  static void factory<T extends Object>(T instance) {
    final Map<String, Object Function()> dependencie =
        <String, Object Function()>{
      T.toString(): () {
        return instance;
      }
    };

    _dependencies.addAll(dependencie);
  }

  static T inject<T extends Object>() {
    final bool containsKey = _dependencies.containsKey(T.toString());

    if (!containsKey) {
      throw Exception('${T.toString()} not declared...');
    }

    final Object Function() item = _dependencies.entries
        .where((element) => element.key == T.toString())
        .first
        .value;

    return (item()) as T;
  }
}
