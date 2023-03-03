// main.dart

import 'package:example/setstate_wrapper.dart';
import 'package:flutter/material.dart';
import 'logic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => wrapWithProvider1(
        initialState: 0,
        transformer1: transformer,
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Builder(
            builder: (context) => wrapWithConsumer(
              builder: builder,
            ),
          ),
        ),
      );
}
