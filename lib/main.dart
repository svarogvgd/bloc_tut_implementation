import 'package:flutter/material.dart';
import 'package:my_bloc_tut/bloc/counter_bloc.dart';
import 'package:my_bloc_tut/bloc/counter_event.dart';
import 'package:my_bloc_tut/bloc/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _bloc = CounterBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<CounterState>(
          stream: _bloc.counter,
          initialData: InitCounterState(),
          builder: (ctx, AsyncSnapshot<CounterState> snapshot) {
            CounterState? state = snapshot.data;
            if (state is InitCounterState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'This is Initial state, the value is ${state.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              );
            } else if (state is CounterStateNewValue) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'You have pushed the button this many times:',
                  ),
                  Text(
                    '${state.counter}',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text('Uuuups! Something went wrong dude...'),
              );
            }
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => _bloc.counterEventSink.add(IncrementEvent()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 8,
          ),
          FloatingActionButton(
            onPressed: () => _bloc.counterEventSink.add(DecrementEvent()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
