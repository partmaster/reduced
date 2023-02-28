// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:reduced/reduced.dart';
import 'state.dart';

class AddItemReducer extends Reducer1<AppState, int> {
  AddItemReducer._();
  static final instance = AddItemReducer._();
  factory AddItemReducer() => instance;
  @override
  AppState call(state, value) =>
      state.copyWith(itemIds: [...state.itemIds, value]);
}

extension AddItemReducerOnReducible on Reducible<AppState> {
  ReducerOnReducible<AppState> addItemReducer(int value) => ReducerOnReducible(
        this,
        Reducer1Adapter(AddItemReducer(), value),
      );
}

class RemoveItemReducer extends Reducer1<AppState, int> {
  RemoveItemReducer._();
  static final instance = RemoveItemReducer._();
  factory RemoveItemReducer() => instance;
  @override
  AppState call(state, value) =>
      state.copyWith(itemIds: [...state.itemIds]..remove(value));
}

extension RemoveItemReducerOnReducible on Reducible<AppState> {
  ReducerOnReducible<AppState> removeItemReducer(int value) =>
      ReducerOnReducible(
        this,
        Reducer1Adapter(RemoveItemReducer(), value),
      );
}
