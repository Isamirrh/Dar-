# Dar+ - Plataforma Solidaria

**Dar+** es una aplicación móvil desarrollada en Flutter diseñada para conectar corazones y necesidades. Esta plataforma permite a los usuarios solicitar ayuda, ofrecer voluntariado, reportar emergencias y gestionar solicitudes solidarias en tiempo real.

## 🚀 Características Principales

- **Sistema de Autenticación**: Flujo completo de inicio de sesión, registro y recuperación de contraseña (simulado).
- **Mapa Interactivo**: Integración con `flutter_map` y OpenStreetMap para visualizar solicitudes y recursos cercanos.
- **Gestión de Ayuda**: Formularios intuitivos para solicitar ayuda personal o reportar necesidades de terceros.
- **Voluntariado**: Sección dedicada para que los voluntarios gestionen sus habilidades y disponibilidad.
- **Asistente Offline**: Sistema de respuestas predefinidas para guiar al usuario en el uso de la app y protocolos de emergencia.
- **Alertas de Emergencia**: Activación rápida de alertas críticas con geolocalización.
- **Temas Personalizables**: Soporte completo para modo claro y oscuro.
- **Arquitectura Profesional**: Código organizado siguiendo patrones de diseño limpios y preparado para integración con Firebase, APIs REST o Supabase.

## 🛠️ Estructura del Proyecto

```text
lib/
├── data/          # Datos mock y constantes
├── models/        # Modelos de datos (User, Request, Emergency, etc.)
├── repositories/  # Gestión de persistencia local (SharedPreferences)
├── screens/       # Pantallas de la aplicación organizadas por módulos
├── services/      # Lógica de negocio y servicios simulados
├── theme/         # Configuración de colores y temas (claro/oscuro)
├── utils/         # Utilidades y constantes globales
└── widgets/       # Componentes de UI reutilizables
```

## 📦 Instalación y Ejecución

1. Asegúrate de tener instalado el [Flutter SDK](https://docs.flutter.dev/get-started/install).
2. Clona este repositorio o descarga el código.
3. Abre el proyecto en **Android Studio** o **VS Code**.
4. Ejecuta `flutter pub get` en la terminal para instalar las dependencias.
5. Inicia un emulador Android.
6. Ejecuta la aplicación con `flutter run`.

## 🔧 Integración Futura

El código incluye comentarios específicos marcados con `TODO:` indicando dónde realizar la conexión con bases de datos reales como:
- **Firebase Auth & Firestore**
- **Supabase**
- **APIs REST Personalizadas**

---
Desarrollado con ❤️ para la comunidad solidaria.
