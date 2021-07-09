import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moviedatabase/screens/search_movie.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Search Movie',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(),
        primaryColor: Colors.white,
      ),
      home: SearchMovies(),
    );
  }
}

