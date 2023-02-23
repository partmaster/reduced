// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reduced_provider/reduced_provider_wrapper.dart';
import 'package:shopper_app/models/props.dart';
import 'package:shopper_app/models/transformer.dart';

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
  Widget build(BuildContext context) {
    return wrapWithConsumer(
      converter: CatalogPropsTransformer.transform,
      builder: ({key, required CatalogProps props}) {
        final itemProps = props.itemById(id);
        return TextButton(
          onPressed: itemProps.onPressed?.call,
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) {
                return Theme.of(context).primaryColor;
              }
              return null; // Defer to the widget's default.
            }),
          ),
          child: itemProps.onPressed == null
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
  final int id;

  const _MyListItem(this.id);

  Widget builder({Key? key, required CatalogProps props}) {
    final itemProps = props.itemById(id);
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
                  color: itemProps.color,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Text(itemProps.name, style: textTheme),
              ),
              const SizedBox(width: 24),
              _AddButton(id: id),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) => wrapWithConsumer(
      converter: CatalogPropsTransformer.transform, builder: builder);
}
