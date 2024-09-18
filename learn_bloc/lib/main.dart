import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_bloc/counter_bloc.dart';
import 'package:learn_bloc/counter_cubit.dart';
import 'package:learn_bloc/counter_event.dart';
import 'package:learn_bloc/counter_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CounterCubit()),
        BlocProvider(create: (context) => CounterBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //void _incrementCounter() {
  //BlocProvider.of<CounterCubit>(context, listen: false).increment();
  //context.read<CounterCubit>().increment();

  //listen true
  //context.watch();
  //}

  @override
  Widget build(BuildContext context) {
    //render semua widget
    //int number = BlocProvider.of<CounterCubit>(context, listen: true).state;
    //render semua widget
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // Text(
            //   '$number',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
            // BlocBuilder<CounterCubit, int>(
            //   builder: (context, value) {
            //     return Text(
            //       '$value',
            //       style: Theme.of(context).textTheme.headlineMedium,
            //     );
            //   },
            // ),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, value) {
                return Text(
                  '${value.number}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: ButtonBar(
        children: [
          FloatingActionButton(
            heroTag: 'decrement',
            onPressed: () {
              //context.read<CounterCubit>().decrement();
              context.read<CounterBloc>().add(OnCounterIncrement());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            heroTag: 'increment',
            onPressed: () {
              //context.read<CounterCubit>().increment();
              context.read<CounterBloc>().add(OnCounterDecrement());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
