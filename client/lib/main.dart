import 'package:client/screens/home.dart';
import 'package:flutter/material.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);
final kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: Color.fromARGB(255, 5, 99, 125),
);
final theme = ThemeData().copyWith(colorScheme: kDarkColorScheme);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,

        cardTheme: CardThemeData().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
        textTheme: ThemeData.dark().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.white,
            fontSize: 15,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: colorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.primaryContainer,
        ),
        cardTheme: CardThemeData().copyWith(
          color: colorScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.normal,
            color: colorScheme.onSecondaryContainer,
            fontSize: 15,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      title: 'Fix hostel',
      home: Home(),
    );
  }
}
