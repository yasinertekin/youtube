import 'package:counter/bloc_provider/counter_cubit.dart';
import 'package:counter/bloc_provider/second_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'bottom_sheet_button_mixin.dart';

final class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: const _FirstViewBody(),
    );
  }
}

final class _FirstViewBody extends StatelessWidget {
  const _FirstViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const CounterControllerRow(),
      appBar: AppBar(
        title: const Text('First View'),
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
            const _GoToSecondViewButton(),
            const _BottomSheetButton(),
          ],
        ),
      ),
    );
  }
}

final class _BottomSheetButton extends StatefulWidget {
  const _BottomSheetButton();

  @override
  State<_BottomSheetButton> createState() => _BottomSheetButtonState();
}

final class _BottomSheetButtonState extends State<_BottomSheetButton>
    with _BottomSheetButtonMixin {
  @override
  Future<void> showCustomBottomSheet(CounterCubit cubit) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: cubit,
          child: Column(
            children: [
              const CounterControllerRow(),
              BlocBuilder<CounterCubit, int>(
                builder: (context, state) {
                  return Text(state.toString());
                },
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CounterCubit>();
    return ElevatedButton(
        onPressed: () => showCustomBottomSheet(cubit),
        child: BlocBuilder<CounterCubit, int>(
          builder: (context, state) {
            return Text(state.toString());
          },
        ));
  }
}

class _GoToSecondViewButton extends StatelessWidget {
  const _GoToSecondViewButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CounterCubit>();
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push<void>(
          MaterialPageRoute<void>(builder: (_) {
            return BlocProvider.value(
              value: cubit,
              child: const SecondView(),
            );
          }),
        );
      },
      child: const Text('Go to Second View'),
    );
  }
}
