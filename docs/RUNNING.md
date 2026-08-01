# Cómo correr Khipu AI

Guía rápida para el equipo. La UI (landing, sidebar, Cursos, Pizarra IA,
Mi progreso) vive en la rama **`sebas`**.

## 1. Requisitos

- **Flutter 3.44+** (canal stable) con Dart 3.12 incluido. Verifica con:

  ```bash
  flutter --version
  ```

  Si no lo tienes, instálalo desde [flutter.dev](https://docs.flutter.dev/get-started/install)
  y agrégalo al PATH (`<ruta-flutter>/bin`).

- Git.
- Opcional (solo para probar Gemma real, no el modo Stub): dispositivo/emulador
  Android **minSdk 26, arm64-v8a**, idealmente ≥6 GB RAM.

## 2. Clonar y ubicarte en la rama

```bash
git clone https://github.com/JPSanchez69/khipu_ai.git
cd khipu_ai
git checkout sebas
cd app
```

## 3. Instalar dependencias

```bash
flutter pub get
```

## 4. Elegir dónde correr

Revisa qué destinos ve Flutter en tu máquina:

```bash
flutter devices
```

| Destino | Comando | Notas |
|---|---|---|
| Chrome (recomendado para iterar UI) | `flutter run -d chrome` | No requiere Android SDK. Gemma real no aplica en web → siempre usa modo **Stub**. |
| Windows desktop | `flutter run -d windows` | Necesita **Modo desarrollador** activado (los plugins usan symlinks). Si falla, corre `start ms-settings:developers` y actívalo. |
| Android (físico o emulador) | `flutter run` | Único destino donde el modelo Gemma real funciona. |

Con la app abierta, `r` hace hot reload y `q` la cierra (desde la terminal
donde corre `flutter run`).

## 5. Modo Stub vs. Gemma real

Por defecto la app usa **StubTeacher** (respuestas fixture, sin modelo
descargado) — así cualquiera puede correr y ver el flujo completo sin
instalar nada. Para probar el modelo real (`gemma-3n-E2B-it-int4.litertlm`,
~3 GB, solo Android): ver [GEMMA_SETUP.md](GEMMA_SETUP.md).

## 6. Correr los tests

```bash
flutter test
```

## Problemas comunes

- **"Building with plugins requires symlink support"** (Windows desktop):
  activa el Modo desarrollador (`start ms-settings:developers`) y vuelve a
  correr.
- **No aparece ningún device en `flutter devices`**: corre
  `flutter doctor` para diagnosticar (SDK de Android, Chrome instalado, etc.).
- **La app abre pero se ve en blanco / crashea en Chrome**: borra la caché
  de build y reintenta: `flutter clean && flutter pub get && flutter run -d chrome`.
