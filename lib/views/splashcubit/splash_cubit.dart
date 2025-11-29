import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starterproject_arkabloc/views/splashcubit/splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashLoading()) {
    _startSplash();
  }

  void _startSplash() async {
    // delay 3 seconds
    await Future.delayed(Duration(seconds: 3));
    emit(SplashLoaded());
  }
}