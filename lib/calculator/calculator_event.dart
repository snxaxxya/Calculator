part of 'calculator_bloc.dart';

@immutable
abstract class CalculatorEvent {}

class AddEvent extends CalculatorEvent{
  final num input;
  AddEvent(this.input);
}

class SubstractEvent extends CalculatorEvent{
  final num input;
  SubstractEvent(this.input);
}

class MultiplyEvent extends CalculatorEvent{
  final num input;
  MultiplyEvent(this.input);
}

class DevidedEvent extends CalculatorEvent{
  final num input;
  DevidedEvent(this.input);
}