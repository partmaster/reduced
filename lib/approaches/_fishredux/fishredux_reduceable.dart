import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' show Colors;

class GlobalStore {
  static Store<GlobalState>? _globalStore;

  static Store<GlobalState> get store =>
      _globalStore ??= createStore<GlobalState>(GlobalState(), buildReducer());
}

abstract class GlobalBaseState {
  Color get themeColor;
  set themeColor(Color color);
}

class GlobalState implements GlobalBaseState, Cloneable<GlobalState> {
  @override
  late Color themeColor;

  @override
  GlobalState clone() {
    return GlobalState();
  }
}

Reducer<GlobalState> buildReducer() {
  return asReducer(
    <Object, Reducer<GlobalState>>{
      GlobalAction.changeThemeColor: _onchangeThemeColor,
    },
  );
}

List<Color> _colors = <Color>[
  Colors.green,
  Colors.red,
  Colors.black,
  Colors.blue
];

GlobalState _onchangeThemeColor(GlobalState state, Action action) {
  final Color next =
      _colors[((_colors.indexOf(state.themeColor) + 1) % _colors.length)];
  return state.clone()..themeColor = next;
}

// action.dart

enum GlobalAction { changeThemeColor }

class GlobalActionCreator {
  static Action onchangeThemeColor() {
    return const Action(GlobalAction.changeThemeColor);
  }
}