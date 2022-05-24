import 'dart:async';

import 'package:my_bloc_tut/bloc/counter_event.dart';
import 'package:my_bloc_tut/bloc/counter_state.dart';

class CounterBloc {
  int _counter = 0;
  CounterBloc() {
    _counterEventController.stream.listen(mapEventToState);
  }

  ///Controller used to send a new States to the view.
  final _counterStateController = StreamController<CounterState>();

  ///The StreamSink is used internally to pass a new values/states so the view.
  StreamSink<CounterState> get _inCounter => _counterStateController.sink;

  ///The Stream is used to expose/send a new states to the view,
  ///view can subscribe/listen for a new states using this.
  Stream<CounterState> get counter => _counterStateController.stream;

  ///Controller used to listen for events.
  final _counterEventController = StreamController<CounterEvent>();

  ///Used to listen for a new events.
  StreamSink<CounterEvent> get counterEventSink => _counterEventController.sink;

  void mapEventToState(CounterEvent event) {
    if (event is IncrementEvent) {
      _counter++;
    } else {
      _counter--;
    }
    _inCounter.add(CounterStateNewValue(counter: _counter));
  }

  dispose() {
    _counterEventController.close();
    _counterStateController.close();
  }
}
