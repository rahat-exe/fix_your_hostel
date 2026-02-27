import 'package:client/main.dart';
import 'package:client/theme/theme.dart';
import 'package:flutter/material.dart';

class RaisedCard extends StatelessWidget {
  const RaisedCard({super.key, required this.complaint, required this.onTap});
  String toUpperCamelCase(String text) {
    return text
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : '',
        )
        .join(' ');
  }

  final Map<String, dynamic>? complaint;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final margin = 6;
    Widget statusBadge(String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text, style: const TextStyle(fontSize: 12)),
      );
    }

    Widget priorityBadge(String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text, style: const TextStyle(fontSize: 12)),
      );
    }

    final cardWidth = screenWidth - (margin * 2);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(
          left: margin.toDouble(),
          right: margin.toDouble(),
          top: 15,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.borderMuted.withValues(alpha: 0.5),
          ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            minRadius: 8,
                            backgroundColor: complaint?['status'] == 'pending'
                                ? Colors.orange[400]
                                : complaint?['status'] == 'in progress'
                                ? Colors.blue[300]
                                : Colors.green[400],
                          ),
                          SizedBox(height: 28),
                        ],
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 4),
                              Text(
                                complaint?['title'] ?? 'No Title',
                                style: Theme.of(context).textTheme.titleLarge!
                                    .copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              statusBadge(
                                toUpperCamelCase(
                                  complaint?['status'] ?? 'Unknown',
                                ),
                              ),
                              SizedBox(width: 6),
                              priorityBadge(
                                toUpperCamelCase(
                                  complaint?['priority'] ?? 'Unknown',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 22,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.8),
                ),
              ],
            ),
            Text(
              complaint?['description'] ?? 'No Description',
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.66),
                fontSize: 16,
              ),
            ),
            Text(
              'Raised by : ${complaint?['createdBy']['name'] ?? 'Unknown User'}',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.66),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
