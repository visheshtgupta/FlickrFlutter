import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    on<CounterIncrementPressed>((event, emit) {
      // TODO: implement event handler
      emit(state + 1);
    });
  }
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }
}
