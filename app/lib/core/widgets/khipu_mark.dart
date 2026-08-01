import 'package:flutter/material.dart';

/// Marca/isotipo de Khipu AI: escudo con el quipu andino, coloreado con
/// la paleta de marca (terracota, turquesa, mostaza, indigo).
class KhipuMark extends StatelessWidget {
  const KhipuMark({super.key, this.size = 40});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/khipu_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
