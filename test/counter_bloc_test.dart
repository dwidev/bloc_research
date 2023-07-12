import 'package:bloc_research/counter/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CounterCubit counterCubit;

  setUp(() {
    counterCubit = CounterCubit();
  });

  group('Counter Cubit', () {
    blocTest(
      "Counter should incerement data",
      build: () => counterCubit,
      act: (c) => c.increment(),
      expect: () => [1],
    );

    blocTest(
      "Counter should decrement data",
      build: () => counterCubit,
      seed: () => 2,
      act: (c) => c.decrement(),
      expect: () => [1],
    );
  });
}
