// bloc.dart

import 'package:flutter/widgets.dart' show BuildContext;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain.dart';
import '../reduceable.dart';

class MyAppStateBloc extends Bloc<Reducer<MyAppState>, MyAppState> {
  MyAppStateBloc()
      : super(
          const MyAppState(
            title: 'Flutter Demo Home Page',
            counter: 0,
          ),
        ) {
    on<Reducer<MyAppState>>((event, emit) => emit(event(state)));
  }

  MyAppState getState() => state;

  late final reduceable = Reduceable(getState, add);

}

extension MyAppStateBlocOnBuildContext on BuildContext {
  MyAppStateBloc get appStateBloc =>
      BlocProvider.of<MyAppStateBloc>(this);
}
