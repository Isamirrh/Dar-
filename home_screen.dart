import 'package:flutter/material.dart';
import 'package:dar_plus/widgets/custom_button.dart';
import 'package:dar_plus/screens/request_help_screen.dart';
import 'package:dar_plus/screens/offer_help_screen.dart';
import 'package:dar_plus/screens/publish_for_others_screen.dart';
import 'package:dar_plus/screens/map_screen.dart';
import 'package:dar_plus/screens/emergency_alert_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EmergencyAlertScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildActionCard(
              context,
              title: 'Solicitar Ayuda',
              description: 'Publica tus necesidades y recibe apoyo.',
              icon: Icons.handshake,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RequestHelpScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              context,
              title: 'Ofrecer Ayuda',
              description: 'Brinda tu apoyo a quienes lo necesitan.',
              icon: Icons.volunteer_activism,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const OfferHelpScreen()),
                );
              },
            ),
            const SizedBox(height: 16),
            _buildActionCard(
              context,
              title: 'Publicar para Otros',
              description: 'Reporta necesidades de terceros.',
              icon: Icons.group_add,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PublishForOthersScreen()),
                );
              },
            ),
            const Spacer(),
            CustomButton(
              text: 'Mapa de Ayuda Activo',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MapScreen()),
                );
              },
              icon: Icons.map,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {required String title, required String description, required IconData icon, required VoidCallback onTap}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 40, color: Theme.of(context).primaryColor),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
