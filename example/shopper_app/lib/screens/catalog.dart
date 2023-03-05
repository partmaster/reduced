// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_setstate/reduced_setstate.dart';

import '../models/props.dart';
import '../models/transformer.dart';

import '../models/state.dart';

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
              (context, index) => _MyListItem(index),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final int id;

  const _AddButton({required this.id});

  @override
  Widget build(BuildContext context) => wrapWithConsumer(
        transformer: (Reducible<AppState> reducible) =>
            CatalogItemPropsTransformer.transform(reducible, id),
        builder: builder,
      );

  Widget builder({key, required CatalogItemProps props}) => Builder(
      builder: (context) => TextButton(
            onPressed: props.onPressed?.call,
            style: ButtonStyle(
              overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
                if (states.contains(MaterialState.pressed)) {
                  return Theme.of(context).primaryColor;
                }
                return null; // Defer to the widget's default.
              }),
            ),
            child: props.onPressed == null
                ? const Icon(Icons.check, semanticLabel: 'ADDED')
                : const Text('ADD'),
          ));
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SliverAppBar(
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

class _MyListItem extends StatelessWidget {
  final int id;

  const _MyListItem(this.id);

  @override
  Widget build(BuildContext context) => wrapWithConsumer(
        transformer: (Reducible<AppState> reducible) =>
            CatalogItemPropsTransformer.transform(reducible, id),
        builder: builder,
      );

  Widget builder({Key? key, required CatalogItemProps props}) =>
      Builder(builder: (context) {
        final textTheme = Theme.of(context).textTheme.titleLarge;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: LimitedBox(
            maxHeight: 48,
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    color: props.color,
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Text(props.name, style: textTheme),
                ),
                const SizedBox(width: 24),
                _AddButton(id: id),
              ],
            ),
          ),
        );
      });
}
