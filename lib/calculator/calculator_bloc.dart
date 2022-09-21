import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {

  @override
  // TODO: implement initialState
  CalculatorState get initialState => CalculatorState(0,[]);

  @override
  Stream<CalculatorState> mapEventToState(CalculatorEvent event) async* {
    // TODO: Add your event logic
    num result = 0;
    if(event is AddEvent){
      result = state.result + event.input;
      state.listHistory.insert(0, '${state.result} + ${event.input} = $result');
    }else if(event is SubstractEvent){
      result = state.result - event.input;
      state.listHistory.insert(0, '${state.result} - ${event.input} = $result');
    }else if(event is MultiplyEvent){
      result = state.result * event.input;
      state.listHistory.insert(0, '${state.result} x ${event.input} = $result');
    }else if(event is DevidedEvent){
      result = state.result / event.input;
      result == double.infinity || result == double.negativeInfinity || result.isNaN
          ? state.listHistory.insert(0,'error')
          : state.listHistory.insert(0,'${state.result} / ${event.input} = $result');
    }else if(event is ClearEvent) {
      result = 0;
      state.listHistory.clear();
    }
    yield CalculatorState(result, state.listHistory);
  }
}
