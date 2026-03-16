import 'package:flutter/material.dart';

class DownVoteButton extends StatelessWidget {
  const DownVoteButton({
    super.key,

    required this.isDownVoted,
    required this.onTap,
  });

  final bool isDownVoted;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDownVoted ? () {} : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: isDownVoted
            ? Theme.of(context).colorScheme.surface.withValues(alpha: 0.5)
            : Theme.of(context).colorScheme.surface,
        foregroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        minimumSize: Size(150, 50),
      ),
      child: isDownVoted
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DownVoted',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.5),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_downward_outlined,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.5),
                  size: 25,
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'DownVote',
                  style: TextStyle(
                    fontSize: 18,
                    color: isDownVoted
                        ? Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.5)
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.9),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 8),
                Icon(
                  Icons.arrow_downward_outlined,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.9),
                  size: 25,
                ),
              ],
            ),
    );
  }
}
