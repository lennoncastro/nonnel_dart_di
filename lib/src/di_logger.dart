import 'package:nonnel/src/models/log.dart';

class DILogger {
  static final List<Log> _logs = <Log>[];

  static List<Log> get logs => _logs;

  static bool _shouldDisplayLogs = false;

  static bool get showLogs => _shouldDisplayLogs;

  static add(Log log) => _logs.add(log);

  static setLogsVisibility({bool showLogs = false}) =>
      _shouldDisplayLogs = showLogs;

  static String showLast() => logs.last.toString();

  static void display({String type = ''}) => logs
      .where((Log log) => log.type == type)
      .forEach((e) => print(e.toString()));
}
