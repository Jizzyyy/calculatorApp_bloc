import 'package:flutter_bloc/flutter_bloc.dart';


// 1. Definisikan Event
abstract class CounterEvent {}
class Increment extends CounterEvent {}
class Decrement extends CounterEvent {}

// 2. Buat Bloc-nya
class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0) {
    
    // Logic saat tombol tambah ditekan
    on<Increment>((event, emit) {
      emit(state + 1);
    });

    // Logic saat tombol kurang ditekan
    on<Decrement>((event, emit) {
      if (state > 0) emit(state - 1); // Validasi: tidak boleh minus
    });
  }
}