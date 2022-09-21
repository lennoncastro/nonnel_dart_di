import 'package:nonnel/src/di_logger.dart';

import 'di_manager.dart';

void factory<T extends Object>(
  T instance, {
  String? named,
}) =>
    DIManager.factory<T>(
      instance,
      named: named,
    );

void singleton<T extends Object>(
  T instance, {
  String? named,
}) =>
    DIManager.singleton<T>(
      instance,
      named: named,
    );

void lazyFactory<T extends Object>(
  T Function() builder, {
  String? named,
}) {
  DIManager.lazyFactory<T>(
    () => builder(),
    named: named,
  );
}

T inject<T extends Object>({
  String? named,
}) =>
    DIManager.inject<T>(named: named);

void reset() => DIManager.reset();

void setLogsVisibility({bool showLogs = false}) =>
    DILogger.setLogsVisibility(showLogs: showLogs);
