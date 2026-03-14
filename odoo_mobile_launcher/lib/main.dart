import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';

// Define custom color from Primary Icon
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = {};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const OdooLauncherApp());
}

class OdooLauncherApp extends StatelessWidget {
  const OdooLauncherApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Odoo Mobile Launcher',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: createMaterialColor(const Color(0xFF545655)), // Primary color: rgba(84, 86, 85) - professional gray
          primaryColor: const Color(0xFF545655), // Professional gray tone
          scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Light gray background for professional look
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF545655), // Professional gray
            foregroundColor: Colors.white,
            elevation: 2, // Slight elevation for professional appearance
            shadowColor: Color(0x40000000), // Subtle shadow
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFe76425), // Secondary color as button color
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF545655), width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFF545655), width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xFFe76425), width: 2), // Secondary color for focus
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          ),
          textTheme: const TextTheme(
            headlineSmall: TextStyle(
              color: Color(0xFF545655), // Professional gray for headings
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            titleLarge: TextStyle(
              color: Color(0xFF545655), // Professional gray for titles
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            bodyMedium: TextStyle(
              color: Color(0xFF333333), // Dark text for readability
              fontSize: 16,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF545655), // Primary color
            secondary: const Color(0xFFe76425), // Secondary color: rgba(231, 100, 37)
            brightness: Brightness.light,
            surface: const Color(0xFFFFFFFF), // Clean white surfaces
            onSurface: const Color(0xFF333333), // Readable text on surfaces
          ),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
