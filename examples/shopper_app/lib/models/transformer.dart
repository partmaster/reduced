// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:reduced/reduced.dart';
import 'props.dart';
import 'state.dart';
import 'reducer.dart';

class ItemById extends IndexedValueGetterCallable<CatalogItemProps> {
  ItemById(this.reducible);

  final Reducible<AppState> reducible;

  @override
  CatalogItemProps call(int id) {
    var state = reducible.getState();
    final item = state.getById(id);
    return CatalogItemProps(
        name: item.name,
        color: item.color,
        onPressed:
            state.itemIds.contains(id) ? null : reducible.addItemReducer(id));
  }

  @override
  int get hashCode => reducible.hashCode;

  @override
  bool operator ==(other) => other is ItemById && reducible == other.reducible;
}

class CatalogPropsTransformer {
  static CatalogProps transform(Reducible<AppState> reducible) => CatalogProps(
        itemById: ItemById(reducible),
        itemIds: reducible.getState().itemIds,
      );
}

class CartPropsTransformer {
  static CartProps transform(Reducible<AppState> reducible) {
    final state = reducible.getState();
    return CartProps(
      totalPrice: '${state.totalPrice}',
      items: state.itemIds
          .map((e) => state.getById(e))
          .map((e) => CartItemProps(
                name: e.name,
                onPressed: reducible.removeItemReducer(e.id),
              ))
          .toList(),
    );
  }
}
