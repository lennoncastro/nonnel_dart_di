import 'dart:core';

class NotDeclaredDependencyError {
  factory NotDeclaredDependencyError(String typeName) =>
      throw Exception('$typeName not declared...');
}
