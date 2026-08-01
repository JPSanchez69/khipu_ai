import 'package:flutter/material.dart';

import '../../core/theme/khipu_colors.dart';

enum NivelEducativo { primaria, secundaria }

enum EstadoCurso { nuevo, enCurso, completado, bloqueado }

/// Curso del catalogo (contenido offline). Ver spec de frontend seccion 4.3.
class Curso {
  const Curso({
    required this.titulo,
    required this.grado,
    required this.nivel,
    required this.icono,
    required this.iconoColor,
    required this.progreso,
    required this.estado,
    required this.temasCompletados,
    required this.temasTotal,
  });

  final String titulo;
  final String grado;
  final NivelEducativo nivel;
  final IconData icono;
  final Color iconoColor;
  final double progreso;
  final EstadoCurso estado;
  final int temasCompletados;
  final int temasTotal;

  bool get bloqueado => estado == EstadoCurso.bloqueado;
}

const cursosDemo = <Curso>[
  // --- Primaria ---
  Curso(
    titulo: 'Matemática · Fracciones',
    grado: '5to de primaria',
    nivel: NivelEducativo.primaria,
    icono: Icons.pie_chart_rounded,
    iconoColor: KhipuColors.primary,
    progreso: 0.6,
    estado: EstadoCurso.enCurso,
    temasCompletados: 6,
    temasTotal: 10,
  ),
  Curso(
    titulo: 'Matemática · Multiplicación',
    grado: '5to de primaria',
    nivel: NivelEducativo.primaria,
    icono: Icons.close_rounded,
    iconoColor: KhipuColors.accent,
    progreso: 1.0,
    estado: EstadoCurso.completado,
    temasCompletados: 9,
    temasTotal: 9,
  ),
  Curso(
    titulo: 'Matemática · Números básicos',
    grado: '3ro de primaria',
    nivel: NivelEducativo.primaria,
    icono: Icons.filter_1_rounded,
    iconoColor: KhipuColors.secondary,
    progreso: 0.35,
    estado: EstadoCurso.enCurso,
    temasCompletados: 3,
    temasTotal: 8,
  ),
  Curso(
    titulo: 'Comunicación · Comprensión lectora',
    grado: '6to de primaria · Próximamente',
    nivel: NivelEducativo.primaria,
    icono: Icons.menu_book_rounded,
    iconoColor: KhipuColors.textMuted,
    progreso: 0,
    estado: EstadoCurso.bloqueado,
    temasCompletados: 0,
    temasTotal: 8,
  ),
  Curso(
    titulo: 'Personal Social',
    grado: 'Primaria · Próximamente',
    nivel: NivelEducativo.primaria,
    icono: Icons.groups_rounded,
    iconoColor: KhipuColors.textMuted,
    progreso: 0,
    estado: EstadoCurso.bloqueado,
    temasCompletados: 0,
    temasTotal: 8,
  ),
  Curso(
    titulo: 'Ciencia y Tecnología',
    grado: 'Primaria · Próximamente',
    nivel: NivelEducativo.primaria,
    icono: Icons.science_rounded,
    iconoColor: KhipuColors.textMuted,
    progreso: 0,
    estado: EstadoCurso.bloqueado,
    temasCompletados: 0,
    temasTotal: 8,
  ),

  // --- Secundaria ---
  Curso(
    titulo: 'Matemática · Ecuaciones lineales',
    grado: '1ro de secundaria',
    nivel: NivelEducativo.secundaria,
    icono: Icons.calculate_rounded,
    iconoColor: KhipuColors.secondary,
    progreso: 0.2,
    estado: EstadoCurso.nuevo,
    temasCompletados: 2,
    temasTotal: 12,
  ),
  Curso(
    titulo: 'Matemática · Geometría',
    grado: '2do de secundaria',
    nivel: NivelEducativo.secundaria,
    icono: Icons.category_rounded,
    iconoColor: KhipuColors.primary,
    progreso: 0,
    estado: EstadoCurso.nuevo,
    temasCompletados: 0,
    temasTotal: 10,
  ),
  Curso(
    titulo: 'Matemática · Álgebra',
    grado: '3ro de secundaria',
    nivel: NivelEducativo.secundaria,
    icono: Icons.extension_rounded,
    iconoColor: KhipuColors.accent,
    progreso: 0.45,
    estado: EstadoCurso.enCurso,
    temasCompletados: 5,
    temasTotal: 11,
  ),
  Curso(
    titulo: 'Comunicación · Redacción y ortografía',
    grado: '4to de secundaria · Próximamente',
    nivel: NivelEducativo.secundaria,
    icono: Icons.edit_note_rounded,
    iconoColor: KhipuColors.textMuted,
    progreso: 0,
    estado: EstadoCurso.bloqueado,
    temasCompletados: 0,
    temasTotal: 6,
  ),
  Curso(
    titulo: 'Personal Social',
    grado: 'Secundaria · Próximamente',
    nivel: NivelEducativo.secundaria,
    icono: Icons.groups_rounded,
    iconoColor: KhipuColors.textMuted,
    progreso: 0,
    estado: EstadoCurso.bloqueado,
    temasCompletados: 0,
    temasTotal: 10,
  ),
  Curso(
    titulo: 'Ciencia y Tecnología',
    grado: 'Secundaria · Próximamente',
    nivel: NivelEducativo.secundaria,
    icono: Icons.science_rounded,
    iconoColor: KhipuColors.textMuted,
    progreso: 0,
    estado: EstadoCurso.bloqueado,
    temasCompletados: 0,
    temasTotal: 10,
  ),
];
