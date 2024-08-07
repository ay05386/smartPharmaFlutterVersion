import 'package:flutter_bloc/flutter_bloc.dart';
import 'counterLogic.dart';


class CounterLogic extends Cubit<CounterState> {
  int num = 0;
  CounterLogic() : super(Init());

  void pls() {
    num++;
    emit(Pls());
  }

  void muns() {
    num--;
    emit(Muns());
  }

  void reset() {
    num = 10;
    emit(Reset());
  }
}
