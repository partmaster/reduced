import 'package:counter_app/view.dart';
import 'package:flutter/material.dart';

import 'model.dart';
import 'util.dart';

void main() {
  const state = MyAppState(
    title: 'Flutter Demo Home Page',
    counter: 0,
  );
  const app = MyApp();
  const provider = StateProvider(state: state, child: app);
  runApp(provider);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePageBuilder(),
    );
  }
}
