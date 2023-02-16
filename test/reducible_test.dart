import 'package:flutter_test/flutter_test.dart';

import 'package:reducible/reducible.dart';

void main() {
  test('adds one to input values', () {
    Reducible(() => false, (p0) { }, true);
  });
}
