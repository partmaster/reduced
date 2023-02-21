// main.dart

import 'package:flutter/widgets.dart';

import 'view/binder.dart';
import 'view/builder.dart';

void main() {
  runApp(const MyAppStateBinder(child: MyAppBuilder()));
}
