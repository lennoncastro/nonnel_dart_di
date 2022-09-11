import 'di_manager.dart';

void factory<T extends Object>(
  T instance, {
  String? named,
}) =>
    DIManager.factory<T>(
      instance,
      named: named,
    );

T inject<T extends Object>({
  String? named,
}) =>
    DIManager.inject<T>(named: named);
