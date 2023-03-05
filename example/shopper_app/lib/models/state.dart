// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:flutter/material.dart' show immutable, Color, Colors;

class AppState {
  AppState({required this.itemIds});

  final List<int> itemIds;

  AppState copyWith({
    List<int>? itemIds,
  }) =>
      AppState(itemIds: itemIds ?? this.itemIds);

  Item getById(int id) => Item(id);

  late final int totalPrice = itemIds.fold(
    0,
    (total, current) => total + getById(current).price,
  );

  @override
  int get hashCode => Object.hashAll(itemIds);

  bool operator ==(other) =>
      other is AppState && ListEquality().equals(itemIds, other.itemIds);
}

@immutable
class Item {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  static List<String> itemNames = [
    'Code Smell',
    'Control Flow',
    'Interpreter',
    'Recursion',
    'Sprint',
    'Heisenbug',
    'Spaghetti',
    'Hydra Code',
    'Off-By-One',
    'Scope',
    'Callback',
    'Closure',
    'Automata',
    'Bit Shift',
    'Currying',
  ];

  Item(this.id)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      : color = Colors.primaries[id % Colors.primaries.length],
        name = itemNames[id % itemNames.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
