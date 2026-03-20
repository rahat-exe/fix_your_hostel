// import 'package:client/main.dart';
// import 'package:client/class/issues.dart';
import 'package:client/screens/hosteller/add_complaint.dart';
import 'package:client/screens/hosteller/add_issue.dart';
import 'package:client/screens/hosteller/ComplaintDetails/complaint_details.dart';
import 'package:client/screens/hosteller/widgets/empty_list.dart';
import 'package:client/screens/hosteller/widgets/progress_indicator.dart';
import 'package:client/theme/theme.dart';
import 'package:client/screens/hosteller/widgets/issue_button.dart';
import 'package:client/util/user_storage.dart';
import 'package:client/screens/hosteller/widgets/raise_card.dart';
import 'package:flutter/material.dart';
import 'package:client/services/api.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    fetchComplaints();
    loadUser();
  }

  Map<String, dynamic>? user;
  Future<void> loadUser() async {
    final userData = await UserStorage.getUser();
    print(userData);
    setState(() {
      user = userData;
    });
    debugPrint(userData.toString());
  }

  void toAddIssuePage(BuildContext context) async {
    final response = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => const AddIssue()));
    if (response == true) {
      fetchComplaints();
    }
  }

  void toAddComplaintPage(BuildContext context) async {
    final response = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => AddComplaint()));
    if (response == true) {
      fetchComplaints();
    }
  }

  List<dynamic> _complaints = [];
  void fetchComplaints() async {
    print('Fetching complaints from API...');
    Api api = Api();
    var data = await api.getComplaints();
    setState(() {
      _complaints = data;
      isLoading = false;
    });
  }

  void toComplaintDetails(
    BuildContext context,
    Map<String, dynamic> complaint,
  ) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ComplaintDetails(complaint: complaint),
      ),
    );

    fetchComplaints();
  }

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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: MediaQuery.of(context).size.width,
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
                    SizedBox(width: 12),
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
                if (isLoading == true)
                  Column(
                    children: [SizedBox(height: 180), ProgressIndicatoring()],
                  )
                else if (_complaints.isEmpty)
                  Column(
                    children: [
                      SizedBox(height: 180),
                      EmptyList(message: 'No Complaints Reported Yet'),
                    ],
                  )
                else
                  for (final complaints in _complaints)
                    if (complaints['type'] == 'public' &&
                        complaints['createdBy']['hostelBlock'] ==
                            user?['hostelBlock'] &&
                        complaints['status'] != 'resolved')
                      RaisedCard(
                        complaint: complaints,
                        onTap: () {
                          toComplaintDetails(context, complaints);
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
