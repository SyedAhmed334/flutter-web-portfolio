import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'controllers/theme_controller.dart';
import 'views/home_screen.dart';
import 'utils/app_colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Syed Ahmed Shah - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primaryColor,
          secondary: AppColors.accentColor,
          surface: AppColors.surfaceColor,
          background: AppColors.backgroundColor,
          onPrimary: Colors.black,
          onSurface: AppColors.textColor,
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              ),
        ).copyWith(
          displayLarge: GoogleFonts.poppins(
            fontSize: 56,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.5,
            color: Colors.white,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
          headlineMedium: GoogleFonts.poppins(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: AppColors.textColorSecondary,
            height: 1.5,
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
