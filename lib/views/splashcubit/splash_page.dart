import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starterproject_arkabloc/views/splashcubit/splash_cubit.dart';
import 'package:starterproject_arkabloc/views/splashcubit/splash_state.dart';
import 'package:starterproject_arkabloc/views/calcbloc/calcbloc_bloc.dart';
import 'package:starterproject_arkabloc/views/calcbloc/calcbloc_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashLoaded) {
          // Navigasi ke Calculator Screen setelah 3 detik
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => BlocProvider(
                create: (context) => CalculatorBloc(),
                child: CalculatorScreen(),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xFF6DD5C3),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Calculator
              Icon(
                Icons.calculate_rounded,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 24),
              // App Name
              Text(
                'Calculator App',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40),
              // Loading Indicator
              CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
