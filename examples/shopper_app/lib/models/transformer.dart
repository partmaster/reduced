// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'state.dart';
import 'reducer.dart';

class CatalogItemPropsTransformer {
  static CatalogItemProps transform(Reducible<AppState> reducible, int id) {
    final item = reducible.state.getById(id);
    return CatalogItemProps(
        name: item.name,
        color: item.color,
        onPressed: reducible.state.itemIds.contains(id)
            ? null
            : reducible.addItemReducer(id));
  }
}

class CartPropsTransformer {
  static CartProps transform(Reducible<AppState> reducible) {
    final state = reducible.state;
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
