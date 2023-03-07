// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'state.dart';
import 'reducer.dart';

class CatalogItemPropsTransformer {
  static CatalogItemProps transform(ReducedStore<AppState> store, int id) {
    final item = store.state.getById(id);
    return CatalogItemProps(
        name: item.name,
        color: item.color,
        onPressed:
            store.state.itemIds.contains(id) ? null : store.addItemReducer(id));
  }
}

class CartPropsTransformer {
  static CartProps transform(ReducedStore<AppState> store) {
    final state = store.state;
    return CartProps(
      totalPrice: '${state.totalPrice}',
      items: state.itemIds
          .map((e) => state.getById(e))
          .map((e) => CartItemProps(
                name: e.name,
                onPressed: store.removeItemReducer(e.id),
              ))
          .toList(),
    );
  }
}
