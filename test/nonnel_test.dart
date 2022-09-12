import 'package:nonnel/nonnel.dart';
import 'package:nonnel/src/errors/invalid_dependency_name.error.dart';
import 'package:nonnel/src/errors/not_declared_dependency.error.dart';
import 'package:test/test.dart';

import '../example/example_utils/a.dart';

void main() {
  group('All tests', () {
    test(
        'When creates a factory with input valid named '
        'Should return a A instance', () {
      //arrange
      DIManager.clearDependencies();
      DIManager.factory(A(), named: 'instanceofA');

      // assert
      expect(
        DIManager.inject(named: 'instanceofA'),
        isA<A>(),
      );
    });

    test(
        'When creates any singleton with input valid named '
        'Should return the first A instance', () {
      //arrange
      DIManager.clearDependencies();
      final firstA = A();
      final secondA = A();
      final thirdA = A();

      // act
      DIManager.singleton(firstA, named: 'instanceofA');
      DIManager.singleton(secondA, named: 'instanceofA');
      DIManager.singleton(thirdA, named: 'instanceofA');

      // assert
      expect(
        DIManager.inject(named: 'instanceofA'),
        isA<A>(),
      );
      expect(DIManager.inject<A>(named: 'instanceofA').time, firstA.time);
    });

    test(
        'When creates a lazy factory with input valid named '
        'Should return a A instance', () {
      //arrange
      DIManager.clearDependencies();
      DIManager.lazyFactory(() => A(), named: 'instanceofA');

      // assert
      expect(
        DIManager.inject(named: 'instanceofA'),
        isA<A>(),
      );
    });

    test(
        'When input invalid named '
        'Should dispatch a InvalidDependencyNameError', () {
      // arrange
      DIManager.clearDependencies();

      // assert
      expect(
        () => DIManager.factory(A(), named: ''),
        throwsA(
          isA<InvalidDependencyNameError>(),
        ),
      );
    });

    test(
        'When input invalid named '
        'Should dispatch a InvalidDependencyNameError', () {
      // arrange
      DIManager.clearDependencies();

      // assert
      expect(
        () => DIManager.lazyFactory(() => A(), named: ''),
        throwsA(
          isA<InvalidDependencyNameError>(),
        ),
      );
    });

    test(
        'When inject a not declared dependency '
        'Should dispatch a NotDeclaredDependencyError', () {
      // arrange
      DIManager.clearDependencies();

      // assert
      expect(
        () => DIManager.inject(named: 'Abc'),
        throwsA(
          isA<NotDeclaredDependencyError>(),
        ),
      );
    });
  });
}
