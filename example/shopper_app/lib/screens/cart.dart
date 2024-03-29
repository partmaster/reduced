// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reduced_provider/reduced_provider.dart';

import '../models/props.dart';
import '../models/mappers.dart';

class MyCart extends StatelessWidget {
  const MyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: Theme.of(context).textTheme.displayLarge),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.yellow,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _CartList(),
              ),
            ),
            const Divider(height: 4, color: Colors.black),
            _CartTotal()
          ],
        ),
      ),
    );
  }
}

class _CartList extends StatelessWidget {
  Widget builder({Key? key, required CartProps props}) => Builder(
        builder: (context) {
          final itemNameStyle = Theme.of(context).textTheme.titleLarge;
          return ListView.builder(
            itemCount: props.items.length,
            itemBuilder: (context, index) {
              final item = props.items[index];
              return ListTile(
                leading: const Icon(Icons.done),
                trailing: IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: item.onPressed,
                ),
                title: Text(
                  item.name,
                  style: itemNameStyle,
                ),
              );
            },
          );
        },
      );

  @override
  Widget build(BuildContext context) =>
      ReducedConsumer(mapper: CartPropsMapper.new, builder: builder);
}

class _CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      ReducedConsumer(mapper: CartPropsMapper.new, builder: builder);

  Widget builder({Key? key, required CartProps props}) =>
      Builder(builder: (context) {
        final hugeStyle =
            Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 48);
        return SizedBox(
          height: 200,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('\$${props.totalPrice}', style: hugeStyle),
                const SizedBox(width: 24),
                FilledButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Buying not supported yet.')));
                  },
                  style: TextButton.styleFrom(foregroundColor: Colors.white),
                  child: const Text('BUY'),
                ),
              ],
            ),
          ),
        );
      });
}
