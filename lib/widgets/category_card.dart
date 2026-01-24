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

    if (text.contains('gas')) return Colors.red;
    if (text.contains('ac') || text.contains('aire')) return Colors.blue;
    if (text.contains('plom')) return Colors.green;
    if (text.contains('electric')) return Colors.blue;
    if (text.contains('pint')) return Colors.red;
    if (text.contains('cerraj')) return Colors.green;

    return Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    final color = getColorByLabel(label);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/create-request',
          arguments: label,
        );
      },
      child: Container(
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
        padding: const EdgeInsets.fromLTRB(8, 14, 8, 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 38,
              color: color.withOpacity(0.8),
            ),
            const SizedBox(height: 6),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: label.length > 15 ? 11.5 : 12.5,
                fontWeight: FontWeight.w600,
                height: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
