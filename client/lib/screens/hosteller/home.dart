// import 'package:client/main.dart';
// import 'package:client/class/issues.dart';
import 'package:client/screens/hosteller/add_complaint.dart';
import 'package:client/screens/hosteller/add_issue.dart';
import 'package:client/screens/hosteller/complaint_details.dart';
import 'package:client/theme/theme.dart';
import 'package:client/widgets/issue_button.dart';
import 'package:client/widgets/main_drawer.dart';
import 'package:client/widgets/raise_card.dart';
import 'package:flutter/material.dart';
import 'package:client/services/api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

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

  List<dynamic> _complaints = [];
  void fetchComplaints() async {
    print('Fetching complaints from API...');
    Api api = Api();
    var data = await api.getComplaints();
    // print('RAW API DATA 👇');
    // print(const JsonEncoder.withIndent('  ').convert(data));
    // print(data[0].keys.toList());
    setState(() {
      _complaints = data;
    });
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

  // final List<Issues> _hostelComplaint = [
  //   Issues(
  //     title: 'Uneccessary High fees',
  //     description:
  //         'Hostel facilities are not improved but they are still increasing the amount',
  //     raisedBy: 'Nayan Jyoti Borah',
  //   ),
  //   Issues(
  //     title: 'Food issue',
  //     description: 'Bad food quality',
  //     raisedBy: 'Afruz alam Barbhuyan',
  //   ),
  //   Issues(
  //     title: 'Dirty washrooms',
  //     description:
  //         'All the washrooms are dirty, there no mugs, taps are broker, hooks are broken',
  //     raisedBy: 'Riddhi sundar sahu',
  //   ),
  //   Issues(
  //     title: 'Water leakage',
  //     description:
  //         'During rain seasons water leaks from the gaps of stairs and it could make someone fall in stairs and cost him a severe injury, you wont be at the dawn this is calling out for you, this calling out for you ',
  //     raisedBy: 'Rahat Islam',
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurface,
        ),
        title: const Text(''),
      ),
      drawer: MainDrawer(),

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
                for (final complaints in _complaints)
                  if (complaints['type'] == 'public')
                    RaiseCard(
                      title: complaints?['title'] ?? 'No Title',
                      description:
                          complaints?['description'] ?? 'No Description',
                      raiser: complaints?['createdBy']['name'],
                      onTap: () {
                        toComplaintDetails(
                          context,
                          complaints['title'],
                          complaints['description'],
                          complaints['createdBy']['name'] ?? 'Anonymous',
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
