// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_provider/reduced_provider_wrapper.dart';
import 'package:shopper_app/models/cart.dart';
import 'package:shopper_app/models/catalog.dart';

class MyCatalog extends StatelessWidget {
  const MyCatalog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _MyAppBar(),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index)),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Item item;

  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    return wrapWithConsumer(
      converter: (Reducible<CartModel> reducible) {
        return reducible.getState();
      },
      builder: ({key, required CartModel props}) {
        return TextButton(
          onPressed: item.onAddPressed?.call,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).primaryColor;
              }
              return null; // Defer to the widget's default.
            }),
          ),
          child: props.items.contains(item)
              ? const Icon(Icons.check, semanticLabel: 'ADDED')
              : const Text('ADD'),
        );
      },
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.displayLarge),
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => context.go('/catalog/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index);

  Item converter(Reducible<CartModel> reducible) {
    final cart = reducible.getState();
    final catalog = cart.catalog;
    final inCart = cart.items.map((e) => e.id).contains(index);
    return catalog.getByPosition(
      index,
      inCart
          ? null
          : BondedReducer(
              reducible,
              Reducer1Adapter(AddItemReducer(), index),
            ),
      inCart
          ? BondedReducer(
              reducible,
              Reducer1Adapter(RemoveItemReducer(), index),
            )
          : null,
    );
  }

  Widget builder({Key? key, required Item props}) {
    final item = props;
    return Builder(builder: (context) {
      var textTheme = Theme.of(context).textTheme.titleLarge;
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: LimitedBox(
          maxHeight: 48,
          child: Row(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: item.color,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Text(item.name, style: textTheme),
              ),
              const SizedBox(width: 24),
              _AddButton(item: item),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) =>
      wrapWithConsumer(converter: converter, builder: builder);
}
