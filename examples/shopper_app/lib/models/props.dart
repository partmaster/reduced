// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced/reduced_callbacks.dart';
import 'package:collection/collection.dart';

class CatalogItemProps {
  CatalogItemProps({
    required this.name,
    required this.color,
    required this.onPressed,
  });

  final String name;
  final Color color;
  final VoidCallable? onPressed;

  @override
  int get hashCode => Object.hash(name, color, onPressed);

  @override
  bool operator ==(other) =>
      other is CatalogItemProps &&
      name == other.name &&
      color == other.color &&
      onPressed == other.onPressed;
}

class CartItemProps {
  CartItemProps({
    required this.name,
    required this.onPressed,
  });

  final String name;
  final VoidCallable onPressed;

  @override
  int get hashCode => Object.hash(name, onPressed);

  @override
  bool operator ==(other) =>
      other is CartItemProps &&
      name == other.name &&
      onPressed == other.onPressed;
}

typedef IndexedValueGetterCallable<T> = Callable1<T, int>;

class CatalogProps {
  CatalogProps({required this.itemById, required this.itemIds});

  final IndexedValueGetterCallable<CatalogItemProps> itemById;
  final List<int> itemIds;

  @override
  int get hashCode => Object.hash(itemById, Object.hashAll(itemIds));

  @override
  bool operator ==(other) =>
      other is CatalogProps && itemById == other.itemById && ListEquality().equals(itemIds, other.itemIds);
}

class CartProps {
  CartProps({required this.totalPrice, required this.items});
  final List<CartItemProps> items;
  final String totalPrice;

  int get hashCode => Object.hash(totalPrice, Object.hashAll(items));

  bool operator ==(Object other) =>
      other is CartProps &&
      totalPrice == other.totalPrice &&
      const DeepCollectionEquality().equals(items, other.items);
}
