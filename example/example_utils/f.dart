import 'a.dart';
import 'special.dart';

class F {
  F(this.special, this.a);
  final Special special;
  final A a;

  void talkar() => special.talkar();
}
