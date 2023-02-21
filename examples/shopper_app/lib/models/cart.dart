// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:reduced/reduced.dart';
import 'package:shopper_app/models/catalog.dart';

class CartState {
  CartState({required this.catalog, this.itemIds = const []});

  final CatalogModel catalog;
  final List<int> itemIds;

  CartState copyWith({CatalogModel? catalog, List<int>? itemIds}) => CartState(
        catalog: catalog ?? this.catalog,
        itemIds: itemIds ?? this.itemIds,
      );

  /// List of items in the cart.
  List<Item> get items =>
      itemIds.map((id) => catalog.getById(id, null, null)).toList();

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);
}

class RemoveItemReducer extends Reducer1<CartModel, int> {
  RemoveItemReducer._();
  static final instance = RemoveItemReducer._();
  factory RemoveItemReducer() => instance;
  @override
  CartModel call(state, value) {
    print('RemoveItemReducer.call($value)');
    final result = CartModel();
    result.catalog = state.catalog;
    for(final item in state.items) {
      result.add(item);
    }
    result.remove(state.catalog.getByPosition(value, null, null));
    return result;
  }
}

class AddItemReducer extends Reducer1<CartModel, int> {
  AddItemReducer._();
  static final instance = AddItemReducer._();
  factory AddItemReducer() => instance;
  @override
  CartModel call(state, value) {
    print('AddItemReducer.call($value)');
    final result = CartModel();
    result.catalog = state.catalog;
    for(final item in state.items) {
      result.add(item);
    }
    result.add(state.catalog.getByPosition(value, null, null));
    return result;
  }
}

class CartModel extends ChangeNotifier {
  /// The private field backing [catalog].
  late CatalogModel _catalog;

  Reducible<CartModel>? reducible;

  /// Internal, private state of the cart. Stores the ids of each item.
  final List<int> _itemIds = [];

  /// The current catalog. Used to construct items from numeric ids.
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    _catalog = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  /// List of items in the cart.
  List<Item> get items => _itemIds
      .map((id) => _catalog.getById(
          id,
          null,
          reducible != null && _itemIds.contains(id)
              ? BondedReducer(
                  reducible!,
                  Reducer1Adapter(RemoveItemReducer(), id),
                )
              : null))
      .toList();

  /// The current total price of all items.
  int get totalPrice =>
      items.fold(0, (total, current) => total + current.price);

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    _itemIds.add(item.id);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Item item) {
    _itemIds.remove(item.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}
