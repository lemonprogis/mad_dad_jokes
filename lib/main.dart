import 'package:flutter/material.dart';
import 'package:mad_dad_jokes/providers/joke_provider.dart';
import 'package:provider/provider.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MadDadJokeApp());
}

class MadDadJokeApp extends StatelessWidget {
  const MadDadJokeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => JokeProvider(),
      child: MaterialApp(
        title: 'Dad Jokes!',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.amber,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white30,
          primaryColor: Colors.deepOrange,
          secondaryHeaderColor: Colors.grey,
          backgroundColor: Colors.deepOrange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        home: const HomeScreen(title: 'Mad Dad Jokes'),
      ),
    );
  }
}
