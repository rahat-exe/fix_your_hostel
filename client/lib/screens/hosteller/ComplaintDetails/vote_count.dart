import 'package:flutter/material.dart';
import 'package:client/theme/theme.dart';

class VoteCount extends StatelessWidget {
  const VoteCount({super.key, required this.title, required this.votes});
  final List<dynamic>? votes;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: BoxBorder.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          SizedBox(width: 5),
          Text(
            votes != null ? votes!.length.toString() : '0',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
