import 'package:dar_plus/models/assistant_message.dart';

class AssistantService {
  final Map<String, String> _predefinedResponses = {
    'emergencia': 'Protocolo de emergencia: Mantén la calma. Hemos activado el protocolo de primeros auxilios y notificado a los centros cercanos. ¿Deseas ver la guía rápida?',
    'ayuda': 'Instrucciones básicas para solicitar ayuda: 1. Dirígete a la sección "Solicitar Ayuda". 2. Elige la categoría de tu necesidad. 3. Describe tu situación y ubicación. 4. Publica tu solicitud.',
    'voluntario': 'Información para voluntarios: Puedes ofrecer tu ayuda en la sección "Ofrecer Ayuda". Allí podrás seleccionar tus habilidades, cambiar tu disponibilidad y ver solicitudes cercanas.',
    'hola': '¡Hola! Soy tu guía inteligente de Dar+. ¿Cómo puedo apoyarte en tu labor hoy?',
    'gracias': 'De nada. Estoy aquí para ayudarte.',
    'mapa': 'El mapa te muestra solicitudes urgentes, centros de asistencia y voluntarios en ruta. Puedes filtrar la información según tus necesidades.',
    'mis solicitudes': 'En la sección "Mis Solicitudes" puedes ver el estado de tus peticiones (Pendiente, En camino, Completada) y gestionarlas.',
    'perfil': 'En tu perfil puedes editar tu información, cambiar el tema de la aplicación y cerrar sesión.',
    'como funciona': 'Dar+ es una plataforma solidaria que conecta personas que necesitan ayuda con voluntarios, organizaciones y recursos cercanos. Funciona mediante solicitudes y ofertas de ayuda.',
    'contacto': 'Si necesitas contactar con soporte, puedes enviar un correo a support@darplus.com.',
    'donar': 'Para realizar donaciones, por favor visita nuestra página web www.darplus.com/donaciones.',
    'reportar abuso': 'Si deseas reportar un abuso, por favor utiliza la opción de "Reportar" en la sección de perfil o contacta a support@darplus.com.',
    'que es dar+': 'Dar+ es una red solidaria de respuesta inmediata que conecta corazones y necesidades.',
    'como me registro': 'Para registrarte, haz clic en "Comenzar" en la pantalla de bienvenida y luego selecciona "Registro". Completa tus datos y crea tu cuenta.',
    'olvide mi contraseña': 'Si olvidaste tu contraseña, en la pantalla de inicio de sesión, haz clic en "¿Olvidaste tu contraseña?" y sigue las instrucciones para recuperarla.',
    'ayuda urgente': 'Si tienes una emergencia, dirígete a la sección "Ayuda Urgente" y activa la alerta. Se notificará a los servicios de emergencia y voluntarios cercanos.',
    'como ofrezco ayuda': 'Para ofrecer ayuda, ve a la sección "Ofrecer Ayuda", selecciona tus habilidades y disponibilidad. Podrás ver las solicitudes cercanas y decidir cómo ayudar.',
    'publicar para otros': 'Si conoces a alguien que necesita ayuda pero no tiene acceso a la aplicación, puedes publicar una solicitud en su nombre desde la sección "Publicar para Otros".',
    'configuracion': 'En la sección de perfil, puedes acceder a la configuración para cambiar el tema de la aplicación y otras preferencias.',
    'privacidad': 'Nuestra política de privacidad está disponible en la sección "Acerca de Dar+" en tu perfil.',
  };

  Future<AssistantMessage> getAssistantResponse(String query) async {
    final lowerCaseQuery = query.toLowerCase();
    for (final keyword in _predefinedResponses.keys) {
      if (lowerCaseQuery.contains(keyword)) {
        return AssistantMessage(
          text: _predefinedResponses[keyword]!,
          isUser: false,
          timestamp: DateTime.now(),
        );
      }
    }
    return AssistantMessage(
      text: 'Lo siento, no entiendo tu pregunta. Por favor, intenta con otra consulta o reformula tu pregunta.',
      isUser: false,
      timestamp: DateTime.now(),
    );
  }
}

class AssistantMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  AssistantMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}
