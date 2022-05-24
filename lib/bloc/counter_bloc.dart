import 'dart:async';

import 'package:my_bloc_tut/bloc/counter_event.dart';

class CounterBloc {
  int _counter = 0;
  CounterBloc() {
    _counterEventController.stream.listen(mapEventToState);
    _counterStateController.add(_counter);
  }
  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  Stream<int> get counter => _counterStateController.stream;

  final _counterEventController = StreamController<CounterEvent>();
  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  void mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(_counter);
  }

  dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
