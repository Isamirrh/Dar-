import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool outline;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.outline = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultBackgroundColor = outline ? Colors.transparent : theme.primaryColor;
    final defaultTextColor = outline ? theme.primaryColor : theme.colorScheme.onPrimary;

    return SizedBox(
      width: double.infinity,
      child: outline
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: textColor ?? defaultTextColor,
                side: BorderSide(color: backgroundColor ?? theme.primaryColor, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: _buildChild(theme, textColor ?? defaultTextColor),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor ?? defaultBackgroundColor,
                foregroundColor: textColor ?? defaultTextColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: _buildChild(theme, textColor ?? defaultTextColor),
            ),
    );
  }

  Widget _buildChild(ThemeData theme, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, color: color),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(color: color),
        ),
      ],
    );
  }
}
