import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starterproject_arkabloc/utils/themecubit.dart';
import 'package:starterproject_arkabloc/views/splashcubit/splash_cubit.dart';
import 'package:starterproject_arkabloc/views/splashcubit/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<ThemeCubit>(create: (context) => ThemeCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocProvider(
          create: (context) => SplashCubit(),
          child: SplashPage(),
        ),
      ),
    );
  }
}
