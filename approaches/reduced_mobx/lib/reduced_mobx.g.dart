// GENERATED CODE - DO NOT MODIFY BY HAND

part of reduced_mobx;

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReducibleStore<S, P1, P2> on ReducibleStoreBase<S, P1, P2>, Store {
  Computed<P1>? _$p1Computed;

  @override
  P1 get p1 => (_$p1Computed ??=
          Computed<P1>(() => super.p1, name: 'ReducibleStoreBase.p1'))
      .value;
  Computed<P2>? _$p2Computed;

  @override
  P2 get p2 => (_$p2Computed ??=
          Computed<P2>(() => super.p2, name: 'ReducibleStoreBase.p2'))
      .value;

  late final _$valueAtom =
      Atom(name: 'ReducibleStoreBase.value', context: context);

  @override
  S get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(S value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  late final _$ReducibleStoreBaseActionController =
      ActionController(name: 'ReducibleStoreBase', context: context);

  @override
  void reduce(Reducer<S> reducer) {
    final _$actionInfo = _$ReducibleStoreBaseActionController.startAction(
        name: 'ReducibleStoreBase.reduce');
    try {
      return super.reduce(reducer);
    } finally {
      _$ReducibleStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
p1: ${p1},
p2: ${p2}
    ''';
  }
}
