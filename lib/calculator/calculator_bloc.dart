import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {

  @override
  // TODO: implement initialState
  CalculatorState get initialState => InitialCalculatorState(0,[]);

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {
    // TODO: Add your event logic
    if(event is AddEvent){
      num result = state.result + event.input;
      state.listHistory.insert(0, '${state.result} + ${event.input} = $result');
    }else if(event is SubstractEvent){
      num result = state.result - event.input;
      state.listHistory.insert(0, '${state.result} - ${event.input} = $result');
    }else if(event is MultiplyEvent){
      num result = state.result * event.input;
      state.listHistory.insert(0, '${state.result} x ${event.input} = $result');
    }else if(event is DevidedEvent){
      num result = state.result / event.input;
      result == double.infinity || result == double.negativeInfinity || result.isNaN
          ? state.listHistory.add('error')
          : state.listHistory.add('${state.result} / ${event.input} = $result');
    }
  }
}
