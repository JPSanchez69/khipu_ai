import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/navigation_providers.dart';
import '../../core/di/providers.dart';
import '../../core/theme/khipu_colors.dart';
import '../../core/theme/khipu_text_styles.dart';
import '../../core/theme/khipu_theme.dart';
import 'curso.dart';

/// Tab "Cursos": filtro por nivel + grillas agrupadas.
/// Ver spec de frontend seccion 4.3.
class CursosScreen extends ConsumerStatefulWidget {
  const CursosScreen({super.key});

  @override
  ConsumerState<CursosScreen> createState() => _CursosScreenState();
}

class _CursosScreenState extends ConsumerState<CursosScreen> {
  NivelEducativo? _filtro;

  @override
  Widget build(BuildContext context) {
    final primaria = cursosDemo
        .where((c) => c.nivel == NivelEducativo.primaria)
        .where((c) => _filtro == null || c.nivel == _filtro)
        .toList();
    final secundaria = cursosDemo
        .where((c) => c.nivel == NivelEducativo.secundaria)
        .where((c) => _filtro == null || c.nivel == _filtro)
        .toList();

    return ListView(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Elige un curso',
                    style: KhipuTextStyles.heading.copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Sin conexión. Todo el contenido ya está en tu celular.',
                    style: KhipuTextStyles.body.copyWith(
                      color: KhipuColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Wrap(
          spacing: 8,
          children: [
            _NivelChip(
              label: 'Todos',
              selected: _filtro == null,
              onTap: () => setState(() => _filtro = null),
            ),
            _NivelChip(
              label: '🧒 Primaria',
              selected: _filtro == NivelEducativo.primaria,
              onTap: () => setState(() => _filtro = NivelEducativo.primaria),
            ),
            _NivelChip(
              label: '🧑 Secundaria',
              selected: _filtro == NivelEducativo.secundaria,
              onTap: () => setState(() => _filtro = NivelEducativo.secundaria),
            ),
          ],
        ),
        if (primaria.isNotEmpty) ...[
          const SizedBox(height: 26),
          _GroupTitle('Primaria'),
          const SizedBox(height: 14),
          _CourseGrid(cursos: primaria),
        ],
        if (secundaria.isNotEmpty) ...[
          const SizedBox(height: 26),
          _GroupTitle('Secundaria'),
          const SizedBox(height: 14),
          _CourseGrid(cursos: secundaria),
        ],
        const SizedBox(height: 16),
      ],
    );
  }
}

class _NivelChip extends StatelessWidget {
  const _NivelChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? KhipuColors.surface : Colors.transparent,
      borderRadius: BorderRadius.circular(KhipuRadius.chip),
      child: InkWell(
        borderRadius: BorderRadius.circular(KhipuRadius.chip),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(KhipuRadius.chip),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: KhipuColors.textPrimary.withValues(alpha: 0.06),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            style: KhipuTextStyles.body.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 14,
              color: selected ? KhipuColors.primary : KhipuColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _GroupTitle extends StatelessWidget {
  const _GroupTitle(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: KhipuTextStyles.body.copyWith(
        fontSize: 13,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.6,
        color: KhipuColors.textMuted,
      ),
    );
  }
}

class _CourseGrid extends StatelessWidget {
  const _CourseGrid({required this.cursos});

  final List<Curso> cursos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cursos.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 280,
        mainAxisExtent: 190,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemBuilder: (context, i) => _CourseCard(curso: cursos[i]),
    );
  }
}

class _CourseCard extends ConsumerWidget {
  const _CourseCard({required this.curso});

  final Curso curso;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bloqueado = curso.bloqueado;

    return Opacity(
      opacity: bloqueado ? 0.55 : 1,
      child: Material(
        color: KhipuColors.surface,
        borderRadius: BorderRadius.circular(KhipuRadius.card),
        child: InkWell(
          borderRadius: BorderRadius.circular(KhipuRadius.card),
          onTap: bloqueado
              ? null
              : () {
                  ref.read(pizarraContextProvider.notifier).set(curso.titulo);
                  ref.read(activeChatIdProvider.notifier).set(null);
                  ref.read(activeTabProvider.notifier).set(ShellTab.pizarra);
                },
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(KhipuRadius.card),
              border: Border.all(color: KhipuColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: curso.iconoColor.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Icon(curso.icono, color: curso.iconoColor, size: 22),
                ),
                const SizedBox(height: 10),
                Text(
                  curso.titulo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: KhipuTextStyles.heading.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  curso.grado,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: KhipuTextStyles.body.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: KhipuColors.textSecondary,
                  ),
                ),
                const Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(99),
                  child: LinearProgressIndicator(
                    value: curso.progreso,
                    minHeight: 7,
                    backgroundColor: KhipuColors.surfaceMuted,
                    valueColor: const AlwaysStoppedAnimation(
                      KhipuColors.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _EstadoBadge(estado: curso.estado),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${curso.temasCompletados}/${curso.temasTotal} temas',
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: KhipuTextStyles.body.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: KhipuColors.textMuted,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EstadoBadge extends StatelessWidget {
  const _EstadoBadge({required this.estado});

  final EstadoCurso estado;

  @override
  Widget build(BuildContext context) {
    final (label, bg, fg) = switch (estado) {
      EstadoCurso.nuevo => (
        'Nuevo',
        KhipuColors.surfaceMuted,
        KhipuColors.textSecondary,
      ),
      EstadoCurso.enCurso => (
        'En curso',
        KhipuColors.secondary.withValues(alpha: 0.14),
        KhipuColors.secondary,
      ),
      EstadoCurso.completado => (
        'Completado',
        KhipuColors.success.withValues(alpha: 0.15),
        KhipuColors.success,
      ),
      EstadoCurso.bloqueado => (
        'Bloqueado',
        KhipuColors.textMuted.withValues(alpha: 0.15),
        KhipuColors.textSecondary,
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(KhipuRadius.chip),
      ),
      child: Text(
        label,
        style: KhipuTextStyles.body.copyWith(
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
      ),
    );
  }
}
