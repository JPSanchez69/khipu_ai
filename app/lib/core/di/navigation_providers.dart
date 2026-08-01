import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Vista raiz de la app: landing (sin registro) o app shell.
/// Ver `khipu_design_tokens.md` / spec de frontend seccion 1: el sidebar
/// solo debe existir dentro de [AppView.app], nunca superpuesto a landing.
enum AppView { landing, app }

final appViewProvider =
    NotifierProvider<AppViewNotifier, AppView>(AppViewNotifier.new);

class AppViewNotifier extends Notifier<AppView> {
  @override
  AppView build() => AppView.landing;

  void enterApp() => state = AppView.app;
  void exitToLanding() => state = AppView.landing;
}

/// Tabs del app shell (sidebar).
enum ShellTab { cursos, pizarra, progreso }

final activeTabProvider =
    NotifierProvider<ActiveTabNotifier, ShellTab>(ActiveTabNotifier.new);

class ActiveTabNotifier extends Notifier<ShellTab> {
  @override
  ShellTab build() => ShellTab.cursos;

  void set(ShellTab tab) => state = tab;
}

/// Titulo del curso desde el que se abrio la Pizarra IA (o null si se
/// entro directo a la pizarra sin pasar por un curso).
final pizarraContextProvider =
    NotifierProvider<PizarraContextNotifier, String?>(
      PizarraContextNotifier.new,
    );

class PizarraContextNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void set(String? cursoTitulo) => state = cursoTitulo;
}
