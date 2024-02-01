import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_app_bloc/Bloc/pet_bloc.dart';
import 'package:pet_app_bloc/history_page.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PetBloc petBloc = PetBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => petBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pet Adoption App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness
              .light, // Set the brightness to light for the light theme
        ),
        darkTheme: ThemeData.dark(),
        // Use the default dark theme
        home: BlocProvider(
          create: (context) => PetBloc(),
          child: AnimatedSplashScreen(
            splash: Image.asset('assets/PetIcon.png',
          ),
            nextScreen: HomePage(),
            splashIconSize: MediaQuery.of(context).size.width,
            splashTransition: SplashTransition.fadeTransition,
            backgroundColor: Colors.white,
          ),
        ),

      ),
    );
  }
}
