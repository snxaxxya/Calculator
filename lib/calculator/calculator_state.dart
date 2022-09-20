part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorState {
  final num result;
  final List<String> listHistory;

  CalculatorState(this.result, this.listHistory);
}

class InitialCalculatorState extends CalculatorState {
  InitialCalculatorState(num result, List<String> listHistory) : super(result, listHistory);
}