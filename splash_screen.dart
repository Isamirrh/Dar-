import 'package:flutter/material.dart';
import 'package:dar_plus/widgets/custom_button.dart';
import 'package:dar_plus/screens/auth/login_screen.dart';
import 'package:dar_plus/screens/emergency_alert_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Logo DAR+
              Icon(
                Icons.favorite_rounded,
                size: 120,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 20),
              Text(
                'Dar+',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                'La red solidaria de respuesta inmediata que conecta corazones y necesidades.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
              ),
              const SizedBox(height: 60),
              CustomButton(
                text: 'Comenzar',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
                icon: Icons.arrow_forward,
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: 'Ayuda Urgente',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EmergencyAlertScreen()),
                  );
                },
                icon: Icons.flash_on,
                outline: true,
                backgroundColor: Theme.of(context).hintColor,
                textColor: Theme.of(context).hintColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
