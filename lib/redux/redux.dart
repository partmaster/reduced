import 'package:counter_app/domain.dart';
import 'package:counter_app/reduceable.dart';
import 'package:redux/redux.dart';

extension ReduceableOnStore on Store<MyAppState> {
  Reduceable<MyAppState> get reduceable => 
    Reduceable(() => state, (reducer) => dispatch(reducer));
}
