import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dar_plus/theme/app_theme.dart';
import 'package:dar_plus/services/auth_service.dart';
import 'package:dar_plus/screens/auth/login_screen.dart';
import 'package:dar_plus/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _currentUser;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    final user = await _authService.getCurrentUser();
    setState(() {
      _currentUser = user;
    });
  }

  Future<void> _logout() async {
    await _authService.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<AppTheme>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 60,
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.2),
              child: Icon(Icons.person, size: 80, color: Theme.of(context).primaryColor),
            ),
            const SizedBox(height: 20),
            Text(
              _currentUser?.name ?? 'Usuario Temporal',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: 10),
            Text(
              _currentUser?.email ?? 'usuario.temporal@example.com',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
            ),
            const SizedBox(height: 40),
            _buildProfileOption(
              context,
              icon: Icons.edit,
              title: 'Editar Perfil',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Funcionalidad de edición de perfil no implementada.')),
                );
              },
            ),
            _buildProfileOption(
              context,
              icon: appTheme.themeMode == ThemeMode.dark ? Icons.light_mode : Icons.dark_mode,
              title: 'Cambiar Tema',
              onTap: () {
                appTheme.toggleTheme();
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.info_outline,
              title: 'Acerca de DAR+',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Dar+',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2026 Dar+. Todos los derechos reservados.',
                  children: [
                    Text('Dar+ es una plataforma solidaria que conecta personas que necesitan ayuda con voluntarios, organizaciones y recursos cercanos.'),
                  ],
                );
              },
            ),
            _buildProfileOption(
              context,
              icon: Icons.logout,
              title: 'Cerrar Sesión',
              onTap: _logout,
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, {required IconData icon, required String title, required VoidCallback onTap, bool isDestructive = false}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, color: isDestructive ? Colors.red : Theme.of(context).primaryColor),
              const SizedBox(width: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: isDestructive ? Colors.red : Theme.of(context).textTheme.bodyLarge?.color,
                    ),
              ),
              const Spacer(),
              Icon(Icons.arrow_forward_ios, size: 16, color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5)),
            ],
          ),
        ),
      ),
    );
  }
}
