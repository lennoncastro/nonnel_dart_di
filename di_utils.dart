import 'di_manager.dart';

void factory<T extends Object>(T instance) => DIManager.factory<T>(instance);

T inject<T extends Object>() => DIManager.inject<T>();
