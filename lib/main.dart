// main.dart

import 'package:flutter/widgets.dart';

import 'binder.dart';
import 'builder.dart';

void main() {
  runApp(const MyAppStateBinder(child: MyAppBuilder()));
}
