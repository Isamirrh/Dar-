import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dar_plus/theme/app_theme.dart';
import 'package:dar_plus/screens/splash_screen.dart';
import 'package:dar_plus/screens/auth/login_screen.dart';
import 'package:dar_plus/screens/base_screen.dart';
import 'package:dar_plus/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize mock data for requests
  // await RequestRepository().initMockRequests(); // Uncomment if you want to re-initialize mock data every time
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(),
      child: Consumer<AppTheme>(
        builder: (context, appTheme, child) {
          return MaterialApp(
            title: 'Dar+',
            debugShowCheckedModeBanner: false,
            theme: appTheme.lightTheme,
            darkTheme: appTheme.darkTheme,
            themeMode: appTheme.themeMode,
            home: FutureBuilder<bool>(
              future: _checkLoginStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(); // Or a loading splash screen
                } else if (snapshot.hasData && snapshot.data == true) {
                  return const BaseScreen();
                } else {
                  return const SplashScreen();
                }
              },
            ),
            routes: {
              '/login': (context) => const LoginScreen(),
              '/home': (context) => const BaseScreen(),
            },
          );
        },
      ),
    );
  }

  Future<bool> _checkLoginStatus() async {
    final authService = AuthService();
    final user = await authService.getCurrentUser();
    return user != null;
  }
}
