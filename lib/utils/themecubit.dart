import 'package:flutter_bloc/flutter_bloc.dart';

// State-nya hanya bool: true (Dark), false (Light)
class ThemeCubit extends Cubit<bool> {
  ThemeCubit() : super(false); // Awalnya Light Mode (false)

  void toggleTheme() {
    emit(!state); // Ubah ke kebalikannya
  }
}
