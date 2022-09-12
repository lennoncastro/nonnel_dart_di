class A {
  A() {
    _time = DateTime.now().toString();
  }

  String _time = '';
  String get time => _time;
}
