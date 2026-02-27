import 'package:flutter/material.dart';
import 'package:client/theme/theme.dart';

class IssueButton extends StatelessWidget {
  const IssueButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
    required this.buttonIcon,
  });
  final String buttonTitle;
  final void Function() onTap;
  final IconData buttonIcon;
  @override
  Widget build(BuildContext context) {
     final screenWidth = MediaQuery.of(context).size.width;
    const horizontalMargin = 12; // left + right padding
    const spacing = 12.0; // SizedBox width between cards
    final cardWidth = (screenWidth - (horizontalMargin * 2) - spacing) / 2;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        height: 80,

        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 12, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.borderMuted.withValues(alpha: 0.5),
          ),
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.6),

          boxShadow: [
            BoxShadow(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.05),
              blurRadius: 30,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttonTitle,

              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 3),
            Icon(buttonIcon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
