import 'package:flutter/material.dart';

class IssueButton extends StatelessWidget {
  const IssueButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
  });
  final String buttonTitle;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 170,
        height: 80,

        alignment: Alignment.center,
        margin: EdgeInsets.only(bottom: 12, top: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.6),

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
        child: Text(
          buttonTitle,

          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
