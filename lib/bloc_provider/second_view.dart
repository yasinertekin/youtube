import 'package:counter/bloc_provider/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondView extends StatelessWidget {
  const SecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second View'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            BlocBuilder<CounterCubit, int>(
              builder: (context, state) {
                return Text(
                  '$state',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: const CounterControllerRow(),
    );
  }
}

class CounterControllerRow extends StatelessWidget {
  const CounterControllerRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'increment',
          onPressed: () => context.read<CounterCubit>().increment(),
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        const SizedBox(width: 8),
        FloatingActionButton(
          heroTag: 'decrement',
          onPressed: () => context.read<CounterCubit>().decrement(),
          tooltip: 'Decrement',
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
