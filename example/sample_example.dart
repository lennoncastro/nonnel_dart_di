import 'package:nonnel/src/di_utils.dart';

import 'example_utils/a.dart';
import 'example_utils/b.dart';
import 'example_utils/c.dart';
import 'example_utils/d.dart';
import 'example_utils/f.dart';

void main() {
  // first, we provide an A
  lazyFactory(() => A());

  // so, we provide a B with an A as parameter
  lazyFactory(() => B(inject<A>()));

  // so, we provide a B with a B as parameter
  lazyFactory(() => C(inject<B>()));

  // we can create name dependencies...
  lazyFactory(() => D(), named: 'tchubaruba');

  // ... and get it passing its name as parameter.
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
