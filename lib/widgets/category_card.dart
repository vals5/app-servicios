import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String label;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.label,
  });

  Color getColorByLabel(String label) {
    final text = label.toLowerCase();

    if (label.contains('Gasista')) return Colors.red;
    if (label.contains('Aire acondicionado')) return Colors.blue;
    if (label.contains('Plomero')) return Colors.green;
    if (label.contains('Electricista')) return Colors.blue;
    if (label.contains('Pintor')) return Colors.red;
    if (label.contains('Cerrajero')) return Colors.green;

    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final color = getColorByLabel(label);

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF7D400).withOpacity(0.3),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: color.withOpacity(0.35),
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 60,
            color: color.withOpacity(0.8),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
