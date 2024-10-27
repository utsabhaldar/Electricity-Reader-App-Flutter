import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const StromleserApp());
}

class StromleserApp extends StatelessWidget {
  const StromleserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stromleser App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
    );
  }
}
