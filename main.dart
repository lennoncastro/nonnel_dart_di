import 'di_utils.dart';

void main() {
  // first, we provide an A
  factory(A());

  // so, we provide a B with an A as parameter
  factory(B(inject<A>()));

  // so, we provide a B with a B as parameter
  factory(C(inject<B>()));

  // we can create name dependencies...
  factory(D(), named: 'tchubaruba');

  // ... and get it passing its name as parameter.
  inject(named: 'tchubaruba');

  // we can create factories and inject depencies in it
  factory(
    F(
      inject(named: 'tchubaruba'),
      inject<A>(),
    ),
  );

  inject<F>().talkar();
}

class A {}

class B {
  B(this.a);
  final A a;

  void talkar() => print('taokey!');
}

class C {
  C(this.b);
  final B b;

  void talkar() => print('compãeiros');
}

abstract class Special {
  void talkar();
}

class D implements Special {
  @override
  void talkar() {
    print('sou o D');
  }
}

class E implements Special {
  @override
  void talkar() {
    print('sou o E');
  }
}

class F {
  F(this.special, this.a);
  final Special special;
  final A a;

  void talkar() => special.talkar();
}
