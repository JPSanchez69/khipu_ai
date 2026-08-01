import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/navigation_providers.dart';
import '../../core/theme/khipu_colors.dart';
import '../../core/theme/khipu_text_styles.dart';
import '../../core/widgets/khipu_mark.dart';
import '../cursos/cursos_screen.dart';
import '../lesson/pizarra_screen.dart';
import '../progreso/progreso_screen.dart';

/// Ancho a partir del cual el sidebar queda fijo en vez de ser un drawer.
/// Ver spec de frontend seccion 4.2 y el `@media (max-width:800px)` del
/// prototipo HTML.
const _wideBreakpoint = 800.0;

/// App shell (sidebar + contenido de tab). Solo se monta cuando
/// `appViewProvider == AppView.app` (ver [LandingScreen]).
class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(activeTabProvider);
    final isWide = MediaQuery.sizeOf(context).width >= _wideBreakpoint;

    final content = switch (tab) {
      ShellTab.cursos => const CursosScreen(),
      ShellTab.pizarra => const PizarraScreen(),
      ShellTab.progreso => const ProgresoScreen(),
    };

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            const _Sidebar(),
            Expanded(
              child: SafeArea(
                left: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(32, 24, 32, 16),
                  child: content,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(_titleFor(tab))),
      drawer: const Drawer(child: _Sidebar(isDrawer: true)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: content,
        ),
      ),
    );
  }

  String _titleFor(ShellTab tab) => switch (tab) {
    ShellTab.cursos => 'Cursos',
    ShellTab.pizarra => 'Pizarra IA',
    ShellTab.progreso => 'Mi progreso',
  };
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar({this.isDrawer = false});

  final bool isDrawer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(activeTabProvider);

    return Container(
      width: isDrawer ? null : 230,
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 18),
      decoration: BoxDecoration(
        color: KhipuColors.surface,
        border: isDrawer
            ? null
            : const Border(right: BorderSide(color: KhipuColors.border)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 22),
            child: Row(
              children: [
                const KhipuMark(size: 34),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Khipu AI',
                    overflow: TextOverflow.ellipsis,
                    style: KhipuTextStyles.heading.copyWith(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          _SidebarLink(
            icon: Icons.school_rounded,
            label: 'Cursos',
            selected: tab == ShellTab.cursos,
            onTap: () => _select(context, ref, ShellTab.cursos),
          ),
          _SidebarLink(
            icon: Icons.draw_rounded,
            label: 'Pizarra IA',
            selected: tab == ShellTab.pizarra,
            onTap: () => _select(context, ref, ShellTab.pizarra),
          ),
          _SidebarLink(
            icon: Icons.emoji_events_rounded,
            label: 'Mi progreso',
            selected: tab == ShellTab.progreso,
            onTap: () => _select(context, ref, ShellTab.progreso),
          ),
          const Spacer(),
          _SidebarLink(
            icon: Icons.logout_rounded,
            label: 'Salir',
            selected: false,
            muted: true,
            onTap: () {
              if (isDrawer) Navigator.of(context).pop();
              ref.read(appViewProvider.notifier).exitToLanding();
              ref.read(activeTabProvider.notifier).set(ShellTab.cursos);
            },
          ),
        ],
      ),
    );
  }

  void _select(BuildContext context, WidgetRef ref, ShellTab tab) {
    ref.read(activeTabProvider.notifier).set(tab);
    if (isDrawer) Navigator.of(context).pop();
  }
}

class _SidebarLink extends StatelessWidget {
  const _SidebarLink({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.muted = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final bool muted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? KhipuColors.primary
        : muted
        ? KhipuColors.textMuted
        : KhipuColors.textSecondary;

    return Material(
      color: selected
          ? KhipuColors.primary.withValues(alpha: 0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          child: Row(
            children: [
              Icon(icon, size: 19, color: color),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: KhipuTextStyles.body.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.5,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
