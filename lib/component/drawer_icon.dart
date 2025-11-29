import 'package:flutter/material.dart';

class DrawerIconItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;
  final Color iconColor;
  final Color textColor;
  final double padding;

  const DrawerIconItem({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
    this.iconColor = const Color.fromARGB(255, 150, 148, 148),
    this.textColor = Colors.white,
    this.padding = 20, 
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
            const SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
