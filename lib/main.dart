import 'package:flutter/material.dart';
import 'package:movies_app/screens/trendingMovies/trending_movies_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movies App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Constants.kPrimaryColor,
      ),
      home: const HomeScreen(),
    );
  }
}