import 'package:flutter/material.dart';

class UpVoteButton extends StatelessWidget {
  const UpVoteButton({ super.key,
    required this.isUpvoted,
    required this.isDownVoted,
    required this.onTap,
  });
  final bool isUpvoted;
  final bool isDownVoted;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return   ElevatedButton(
                                onPressed: isUpvoted || isDownVoted
                                    ? () {}
                                    : onTap,

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isUpvoted || isDownVoted
                                      ? Theme.of(context).colorScheme.surface
                                            .withValues(alpha: 0.6)
                                      : Theme.of(context).colorScheme.surface,

                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surface,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  minimumSize: Size(150, 50),
                                ),
                                child: isUpvoted
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'UpVoted',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.5),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.arrow_upward_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.5),
                                            size: 25,
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'UpVote',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: isUpvoted || isDownVoted
                                                  ? Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withValues(alpha: 0.5)
                                                  : Theme.of(context)
                                                        .colorScheme
                                                        .onSurface
                                                        .withValues(alpha: 0.9),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.arrow_upward_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.9),
                                            size: 25,
                                          ),
                                        ],
                                      ),
                              );
  }
}