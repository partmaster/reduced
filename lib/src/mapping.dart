import 'store.dart';

class MappingContext<S1, S2, RC> {
  final StoreSnapshot<S1> appSnapshot;
  final StoreSnapshot<S2> pageSnapshot;
  final RC routingContext;

  MappingContext({
    required this.appSnapshot,
    required this.pageSnapshot,
    required this.routingContext,
  });
}

/// A function that maps a mapping context to props.
///
/// The type parameter `S1` is the type of the app [StoreSnapshot].
/// The type parameter `S2` is the type of the page [StoreSnapshot].
/// The type parameter `RC` is the type of the routing context.
/// The type parameter `P` is the return type of the function.
typedef PropsMapper<S1, S2, RC, P> = P Function(
  MappingContext<S1, S2, RC> mappingContext,
);
