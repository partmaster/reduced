// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:reduced/reduced.dart';

import 'props.dart';
import 'state.dart';
import 'events.dart';

class CatalogItemPropsMapper extends CatalogItemProps {
  CatalogItemPropsMapper(
    AppState state,
    EventProcessor<AppState> processor,
    int id,
  ) : this._(state, processor, state.getById(id));

  CatalogItemPropsMapper._(
      AppState state, EventProcessor<AppState> processor, Item item)
      : super(
            name: item.name,
            color: item.color,
            onPressed: state.itemIds.contains(item.id)
                ? null
                : processor.itemAdded(item.id));
}

class CartPropsTransformer extends CartProps {
  CartPropsTransformer(AppState state, EventProcessor<AppState> processor)
      : super(
          totalPrice: '${state.totalPrice}',
          items: state.itemIds
              .map((e) => state.getById(e))
              .map((e) => CartItemProps(
                    name: e.name,
                    onPressed: processor.itemRemoved(e.id),
                  ))
              .toList(),
        );
}
