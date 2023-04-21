// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'state.dart';
import 'events.dart';

class CatalogItemPropsMapper extends CatalogItemProps {
  CatalogItemPropsMapper(
    StoreSnapshot<AppState> snapshot,
    int id,
  ) : this._(snapshot, snapshot.state.getById(id));

  CatalogItemPropsMapper._(
    StoreSnapshot<AppState> snapshot,
    Item item,
  ) : super(
            name: item.name,
            color: item.color,
            onPressed: snapshot.state.itemIds.contains(item.id)
                ? null
                : snapshot.processor.itemAdded(item.id));
}

class CartPropsMapper extends CartProps {
  CartPropsMapper(
    StoreSnapshot<AppState> snapshot,
    String? routeName,
  ) : super(
          totalPrice: '${snapshot.state.totalPrice}',
          items: snapshot.state.itemIds
              .map((e) => snapshot.state.getById(e))
              .map((e) => CartItemProps(
                    name: e.name,
                    onPressed: snapshot.processor.itemRemoved(e.id),
                  ))
              .toList(),
        );
}
