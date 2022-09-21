import 'package:nonnel/nonnel.dart';
import 'package:test/test.dart';

import '../example/example_utils/a.dart';

void main() {
  setUpAll(() => reset());

  group('All tests', () {
    test(
        'When creates a factory with input valid named '
        'Should return a A instance', () {
      //arrange
      factory(A(), named: 'instanceofA');

      // assert
      expect(
        inject(named: 'instanceofA'),
        isA<A>(),
      );
    });

    test(
        'When creates any singleton with input valid named '
        'Should return the first A instance', () {
      //arrange
      final firstA = A();
      final secondA = A();
      final thirdA = A();

      // act
      singleton(firstA, named: 'instanceofA');
      singleton(secondA, named: 'instanceofA');
      singleton(thirdA, named: 'instanceofA');

      // assert
      expect(
        inject(named: 'instanceofA'),
        isA<A>(),
      );
      expect(inject<A>(named: 'instanceofA').time, firstA.time);
    });

    test(
        'When creates a lazy factory with input valid named '
        'Should return a A instance', () {
      //arrange
      lazyFactory(() => A(), named: 'instanceofA');

      // assert
      expect(
        inject(named: 'instanceofA'),
        isA<A>(),
      );
    });

    test(
        'When input invalid named '
        'Should dispatch a InvalidDependencyNameError', () {
      // assert
      expect(
        () => factory(A(), named: ''),
        throwsA("Invalid dependency name error: "),
      );
    });

    test(
        'When inject a not declared dependency '
        'Should dispatch a NotDeclaredDependencyError', () {
      // assert
      expect(
        () => inject(named: 'Abc'),
        throwsA(
          'Not declared dependency: Abc',
        ),
      );
    });
  });
}
