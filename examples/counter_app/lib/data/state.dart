// state.dart

class MyAppState {
  const MyAppState({required this.title, this.counter = 0});

  final String title;
  final int counter;

  MyAppState copyWith({String? title, int? counter}) => MyAppState(
        title: title ?? this.title,
        counter: counter ?? this.counter,
      );

  @override
  get hashCode => Object.hash(title, counter);

  @override
  operator ==(other) =>
      other is MyAppState && title == other.title && counter == other.counter;
}
