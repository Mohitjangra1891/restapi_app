import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/splashscreen.dart';
import 'providers/moviedata_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => moviedata_provider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MovieApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
          useMaterial3: true,
          textTheme: TextTheme(
            headline2: TextStyle(color: Colors.white),
            bodyText1: TextStyle(color: Colors.white),
          ),
        ),
        home: const splashScreen(),
      ),
    );
  }
}
