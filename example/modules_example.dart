import 'package:nonnel/src/di_utils.dart';

import 'example_utils/a.dart';
import 'example_utils/b.dart';
import 'example_utils/c.dart';
import 'example_utils/d.dart';
import 'example_utils/f.dart';

// first, you need to include all the modules in order of execution
void main() {
  mainModule();
  secondaryModule();
  ThirdModule();
}

// creating a module using a method
void mainModule() {
  // providing a lazy factory for A
  lazyFactory(() => A());
}

// creating a second module using a method
// and injecting a dependency from mainmodule
void secondaryModule() {
  // so, we provide a B with an A as parameter
  lazyFactory(() => B(inject<A>()));
}

// creating a third module using a class
// you can use both method and class to represents your modules
class ThirdModule {
  ThirdModule() {
    // lazyFactory, we provide a B with a B as parameter
    lazyFactory(() => C(inject<B>()));

    // we can create name dependencies
    lazyFactory(() => D(), named: 'tchubaruba');

    // ... and get it passing its name as parameter
    inject(named: 'tchubaruba');

    // we can create factories and inject depencies in it
    lazyFactory(
      () => F(
        inject(named: 'tchubaruba'),
        inject<A>(),
      ),
    );

    inject<F>().talkar();
  }
}
