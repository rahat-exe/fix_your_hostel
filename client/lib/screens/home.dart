import 'package:client/screens/add_issue.dart';
import 'package:client/widgets/raise_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          'Fix your hostel',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface.withValues(alpha: 0.8),
              Theme.of(context).colorScheme.surface,
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (ctx) => const AddIssue()));
              },
              child: Container(
                width: 400,
                height: 80,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(
                  left: 35,
                  right: 35,
                  bottom: 12,
                  top: 20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.onPrimary,
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
                  'Personal\n Room Problems',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              width: 450,
              height: 80,
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.only(left: 35, right: 35, bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).colorScheme.onPrimary,
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
                'Raise\n Hostel Issues',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 18,
                ),
              ),
            ),
            RaiseCard(
              title: 'Food issue',
              description: 'Bad food quality',
              raiser: 'Afruz alam Barbhuyan',
            ),
            RaiseCard(
              title: 'Dirty washrooms',
              description:
                  'All the washrooms are dirty, there no mugs, taps are broker, hooks are broken',
              raiser: 'Riddhi sundar sahu',
            ),
            RaiseCard(
              title: 'Water leakage',
              description:
                  'During rain seasons water leaks from the gaps of stairs and it could make someone fall in stairs and cost him a severe injury',
              raiser: 'Rahat Islam',
            ),
          ],
        ),
      ),
    );
  }
}
