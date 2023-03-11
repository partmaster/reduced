// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:reduced/reduced.dart';

import 'state.dart';

class ItemAdded extends Event1<AppState, int> {
  ItemAdded._();
  static final instance = ItemAdded._();
  factory ItemAdded() => instance;
  @override
  AppState call(state, value) =>
      state.copyWith(itemIds: [...state.itemIds, value]);
}

extension ItemAdedOnReducedStore on ReducedStore<AppState> {
  CallableAdapter<AppState> itemAdded(int value) => CallableAdapter(
        this,
        Event1Adapter(ItemAdded(), value),
      );
}

class ItemRemoved extends Event1<AppState, int> {
  ItemRemoved._();
  static final instance = ItemRemoved._();
  factory ItemRemoved() => instance;
  @override
  AppState call(state, value) =>
      state.copyWith(itemIds: [...state.itemIds]..remove(value));
}

extension ItemRemovedOnReducedStore on ReducedStore<AppState> {
  CallableAdapter<AppState> itemRemoved(int value) => CallableAdapter(
        this,
        Event1Adapter(ItemRemoved(), value),
      );
}
