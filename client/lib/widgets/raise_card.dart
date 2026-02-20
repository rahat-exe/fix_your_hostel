import 'package:client/main.dart';
import 'package:flutter/material.dart';

class RaiseCard extends StatelessWidget {
  const RaiseCard({
    super.key,
    required this.title,
    required this.description,
    required this.raiser,
  });
  final String title;
  final String description;
  final String raiser;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(left: 16, right: 16, top: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary.withValues(alpha: .96),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.primary.withValues(alpha: 0.05),
            blurRadius: 30,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            description,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.66),
              fontSize: 16,
            ),
          ),
          Text(
            'Raised by : $raiser',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.66),
            ),
          ),
        ],
      ),
    );
  }
}
