import 'package:client/screens/home.dart';
import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';

//seed colors
final colorScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);
// final kDarkColorScheme = ColorScheme.fromSeed(
//   brightness: Brightness.dark,
//   seedColor:AppColors.bgDark,
// );

final darktheme = ThemeData().copyWith(
  scaffoldBackgroundColor: AppColors.bgDark,
  primaryColor: AppColors.primary,

  colorScheme: ColorScheme.dark(
    surface: AppColors.bgLight,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    error: AppColors.danger,
  ),

  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: AppColors.text),
    bodyMedium: TextStyle(color: AppColors.textMuted),
  ),

  dividerColor: AppColors.borderMuted,
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: darktheme,
      theme: ThemeData().copyWith(
        colorScheme: colorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorScheme.primaryContainer,
          foregroundColor: colorScheme.onPrimaryContainer,
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
