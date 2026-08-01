# Khipu AI

Tutor educativo con Gemma 3n E2B, pizarra pedagógica, voz e historial local.

## Ejecutar en Chrome con Gemma local

1. Coloca el modelo con este nombre exacto:

   ```text
   khipu_ai\models\gemma-3n-E2B-it-int4.litertlm
   ```

2. Desde la raíz del repositorio ejecuta:

   ```powershell
   .\run_web.cmd
   ```

   Si ya estás dentro de `app`, ejecuta:

   ```powershell
   ..\run_web.cmd
   ```

3. En Chrome abre **Pizarra IA**, pulsa el icono del modelo y selecciona
   **Conectar modelo local (Chrome)**. La primera instalación copia el modelo
   al almacenamiento OPFS del perfil de Chrome y puede tardar varios minutos.
   Las siguientes ejecuciones reutilizan esa copia.

El lanzador evita el bloqueo de Flutter causado por rutas con espacios, inicia
un servidor local en `127.0.0.1:8765` con CORS/Range y mantiene la aplicación
siempre en `127.0.0.1:7357`. El puerto fijo permite que Chrome reutilice el
mismo almacenamiento OPFS en cada ejecución. Además utiliza el perfil
persistente `%LOCALAPPDATA%\KhipuAI\ChromeProfile`, porque el perfil temporal
que Flutter crea normalmente puede eliminar el modelo al terminar. Para
detenerlo usa `Ctrl+C`.

> Chrome no puede entregar directamente a Flutter una ruta como `C:\...`.
> Por eso el modelo se sirve únicamente por HTTP local; no se sube a Internet.
> LiteRT-LM web es actualmente de texto: las fotos quedan disponibles para
> Android, mientras Chrome prueba preguntas escritas o por micrófono.

## Perfil y tipos de respuesta

En **Pizarra IA** usa el icono de persona para editar:

- edad y grado;
- nivel detectado;
- idioma (por defecto `es-PE`);
- preferencia de aprendizaje.

La asignatura y el tema se obtienen del curso/cuaderno activo. Cada pregunta se
envía al modelo con ese contexto y uno de estos modos:

- **Simple:** frases breves y 4–6 acciones de pizarra.
- **Estándar:** explicación más ejemplo y 6–10 acciones.
- **Detallada:** razonamiento, pasos y verificación; 10–16 acciones.

## SQLite e historial

La persistencia usa Drift sobre SQLite. En Chrome, SQLite se ejecuta mediante
WebAssembly y guarda datos en OPFS/IndexedDB; en Android usa la base local del
dispositivo. El esquema conserva:

```text
cursos predefinidos
  └─ cuadernos del estudiante
       └─ chats
            └─ turnos (pregunta + LessonScript JSON + narración + perfil)
```

El panel **Historial de este chat** permite pulsar una explicación terminada y
reproducir nuevamente la narración y la pizarra desde el JSON guardado.

## Voz

La app no incluye una voz propia. `flutter_tts` usa Web Speech API en Chrome y
por tanto una voz española instalada/disponible en Windows/Chrome. Se prioriza
`es-PE`, luego `es-MX`, `es-ES`, `es-US` y `es-AR`. El valor inicial es velocidad
`0.52`, tono `1.0` y una pausa de 60 ms entre fragmentos.

En **Pizarra IA** pulsa el icono de voz para ver la voz elegida, seleccionar otra,
probarla y cambiar velocidad/tono. La configuración se guarda en SQLite.

## Desarrollo

```powershell
cd app
flutter pub get
flutter test
flutter run                  # Android (SDK + minSdk 26)
```

Al modificar las tablas Drift:

```powershell
dart run build_runner build
dart compile js -O4 web\drift_worker.dart -o web\drift_worker.js
```

## Documentación

- [Cómo correr el proyecto](docs/RUNNING.md)
- [Arquitectura](docs/ARCHITECTURE.md)
- [Gemma](docs/GEMMA_SETUP.md)
- [LessonScript](docs/lesson_script_v0.1.schema.json)
