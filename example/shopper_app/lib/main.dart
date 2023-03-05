// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reduced_provider/reduced_provider.dart';
import 'package:window_size/window_size.dart';

import 'common/theme.dart';
import 'models/state.dart';
import 'screens/cart.dart';
import 'screens/catalog.dart';
import 'screens/login.dart';

void main() {
  setupWindow();
  runApp(const MyApp());
}

const double windowWidth = 400;
const double windowHeight = 800;

void setupWindow() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    WidgetsFlutterBinding.ensureInitialized();
    setWindowTitle('Reducible Demo');
    setWindowMinSize(const Size(windowWidth, windowHeight));
    setWindowMaxSize(const Size(windowWidth, windowHeight));
    getCurrentScreen().then((screen) {
      setWindowFrame(Rect.fromCenter(
        center: screen!.frame.center,
        width: windowWidth,
        height: windowHeight,
      ));
    });
  }
}

GoRouter router() => GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const MyLogin(),
        ),
        GoRoute(
          path: '/catalog',
          builder: (context, state) => const MyCatalog(),
          routes: [
            GoRoute(
              path: 'cart',
              builder: (context, state) => const MyCart(),
            ),
          ],
        ),
      ],
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => wrapWithProvider(
        initialState: AppState(itemIds: []),
        child: MaterialApp.router(
          title: 'Provider Demo',
          theme: appTheme,
          routerConfig: router(),
        ),
      );
}
