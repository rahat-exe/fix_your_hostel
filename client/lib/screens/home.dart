// import 'package:client/main.dart';
import 'package:client/class/issues.dart';
import 'package:client/screens/add_complaint.dart';
import 'package:client/screens/add_issue.dart';
import 'package:client/screens/complaint_details.dart';
import 'package:client/theme/theme.dart';
import 'package:client/widgets/issue_button.dart';
import 'package:client/widgets/raise_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({super.key});
  void toAddIssuePage(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const AddIssue()));
  }

  void toAddComplaintPage(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => AddComplaint()));
  }

  void toComplaintDetails(
    BuildContext context,
    String title,
    String description,
    String raisedBy,
  ) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ComplaintDetails(
          title: title,
          description: description,
          raisedBy: raisedBy,
        ),
      ),
    );
  }

  final List<Issues> _hostelComplaint = [
    Issues(
      title: 'Uneccessary High fees',
      description:
          'Hostel facilities are not improved but they are still increasing the amount',
      raisedBy: 'Nayan Jyoti Borah',
    ),
    Issues(
      title: 'Food issue',
      description: 'Bad food quality',
      raisedBy: 'Afruz alam Barbhuyan',
    ),
    Issues(
      title: 'Dirty washrooms',
      description:
          'All the washrooms are dirty, there no mugs, taps are broker, hooks are broken',
      raisedBy: 'Riddhi sundar sahu',
    ),
    Issues(
      title: 'Water leakage',
      description:
          'During rain seasons water leaks from the gaps of stairs and it could make someone fall in stairs and cost him a severe injury,you wont be at the dawn this is calling out for you, this calling out for you ',
      raisedBy: 'Rahat Islam',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.bgDark,
              AppColors.bgDark.withValues(alpha: 0.90),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Container(
                  padding: EdgeInsets.only(left: 16),
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                        'Quick Actions',

                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(
                            context,
                          ).colorScheme.onSurface.withValues(alpha: 0.8),
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.bolt,
                        size: 30,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.8),
                      ),
                    ],
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IssueButton(
                      buttonTitle: 'My Room Issue',
                      onTap: () {
                        toAddIssuePage(context);
                      },
                      buttonIcon: Icons.home,
                    ),
                    SizedBox(width: 10),
                    IssueButton(
                      buttonTitle: 'Submit\nHostel Complaint',
                      onTap: () {
                        toAddComplaintPage(context);
                      },
                      buttonIcon: Icons.apartment,
                    ),
                  ],
                ),

                Container(
                  padding: EdgeInsets.only(left: 16, top: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Reported Hostel Issues : ',

                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withValues(alpha: 0.8),
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                for (final complaints in _hostelComplaint)
                  RaiseCard(
                    title: complaints.title,
                    description: complaints.description,
                    raiser: complaints.raisedBy,
                    onTap: () {
                      toComplaintDetails(
                        context,
                        complaints.title,
                        complaints.description,
                        complaints.raisedBy,
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
              color: Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),

            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),
            label: 'account',
          ),
        ],
      ),
    );
  }
}
