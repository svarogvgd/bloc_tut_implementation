abstract class CounterState {}

class CounterStateNewValue extends CounterState {
  final int counter;
  CounterStateNewValue({
    required this.counter,
  });
}

class InitCounterState extends CounterState {
  final int counter = 0;
}
