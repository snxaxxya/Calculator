part of 'calculator_bloc.dart';

@immutable
class CalculatorState {
  final num result;
  final List<String> listHistory;

  CalculatorState(this.result, this.listHistory);
}