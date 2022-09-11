final Map<String, Object Function()> dependencies =
    <String, Object Function()>{};

void factory<T extends Object>(T instance) {
  final Map<String, Object Function()> dependencie =
      <String, Object Function()>{
    T.toString(): () {
      return instance;
    }
  };

  dependencies.addAll(dependencie);
}

T inject<T extends Object>() {
  final bool containsKey = dependencies.containsKey(T.toString());

  if (!containsKey) {
    throw Exception('${T.toString()} not declared...');
  }

  final Object Function() item = dependencies.entries
      .where((element) => element.key == T.toString())
      .first
      .value;

  return (item()) as T;
}

void main() {
  factory(A());
  final A a = inject<A>();

  factory(B(a));
  final B b = inject<B>();

  factory(C(b));

  factory(D());
  factory(E());

  inject<D>();
  inject<E>();

  factory(F(inject<D>(), inject<A>()));
  factory(F(inject<E>(), inject<A>()));

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
