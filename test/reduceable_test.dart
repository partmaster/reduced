import 'package:flutter_test/flutter_test.dart';

import 'package:reduceable/reduceable.dart';

void main() {
  test('adds one to input values', () {
    Reduceable(() => false, (p0) { }, true);
  });
}
