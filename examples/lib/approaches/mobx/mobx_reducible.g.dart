// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mobx_reducible.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$MyStore on MyStoreBase, Store {
  Computed<MyHomePageProps>? _$homePagePropsComputed;

  @override
  MyHomePageProps get homePageProps => (_$homePagePropsComputed ??=
          Computed<MyHomePageProps>(() => super.homePageProps,
              name: 'MyStoreBase.homePageProps'))
      .value;
  Computed<MyCounterWidgetProps>? _$conterWidgetPropsComputed;

  @override
  MyCounterWidgetProps get conterWidgetProps => (_$conterWidgetPropsComputed ??=
          Computed<MyCounterWidgetProps>(() => super.conterWidgetProps,
              name: 'MyStoreBase.conterWidgetProps'))
      .value;

  late final _$valueAtom = Atom(name: 'MyStoreBase.value', context: context);

  @override
  MyAppState get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(MyAppState value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$MyStoreBaseActionController =
      ActionController(name: 'MyStoreBase', context: context);

  @override
  void reduce(Reducer<MyAppState> reducer) {
    final _$actionInfo =
        _$MyStoreBaseActionController.startAction(name: 'MyStoreBase.reduce');
    try {
      return super.reduce(reducer);
    } finally {
      _$MyStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
homePageProps: ${homePageProps},
conterWidgetProps: ${conterWidgetProps}
    ''';
  }
}
