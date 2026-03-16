import 'package:client/screens/admin/admin_complaints.dart';
import 'package:client/screens/admin/admin_insights.dart';
import 'package:client/screens/admin/approval.dart';
import 'package:client/screens/admin/widget/issue_card.dart';
import 'package:client/screens/admin/widget/quick_button.dart';
import 'package:client/screens/hosteller/ComplaintDetails/complaint_details.dart';
// import 'package:client/theme/theme.dart';
import 'package:client/util/user_storage.dart';

import 'package:flutter/material.dart';
import 'package:client/screens/admin/widget/card_box.dart';
import 'package:client/services/api.dart ';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Map<String, dynamic>? admin;
  bool isAdminLoading = true;
  bool isComplaintsLoading = true;
  List<dynamic> _complaints = [];

  // track the selected tab so we can style the bar correctly
  int getCount(String status) {
    int count = 0;
    for (final complaint in _complaints) {
      if (complaint?['status'] == status) {
        count++;
      }
    }
    return count;
  }

  void toComplaintDetails(Map<String, dynamic> complaint) async {
    final response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ComplaintDetails(complaint: complaint),
      ),
    );
    print(response);
    if (response == true) {
      fetchComplaints();
    }
  }

  @override
  void initState() {
    super.initState();

    fetchAdmin();
    fetchComplaints();
  }

  Future<void> fetchAdmin() async {
    final adminData = await UserStorage.getUser();
    setState(() {
      admin = adminData;
      isAdminLoading = false;
    });
  }

  void fetchComplaints() async {
    Api api = Api();
    var data = await api.getComplaints();
    setState(() {
      _complaints = data;
      isComplaintsLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 12.0; // SizedBox width between cards
    final topComplaints =
        _complaints
            .where((c) => c['type'] == "public" && c['status'] == "pending")
            .toList()
          ..sort((a, b) {
            int votesA = (a['upvotes'] as List?)?.length ?? 0;
            int votesB = (b['upvotes'] as List?)?.length ?? 0;
            return votesB.compareTo(votesA);
          });
    return Scaffold(
      body: SafeArea(
        child: (isAdminLoading || isComplaintsLoading)
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome ${admin?['name']}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        // Cards Section
                        Row(
                          children: [
                            CardBox(
                              title: 'Total Issues',
                              count: _complaints.length,
                            ),
                            SizedBox(width: spacing),
                            CardBox(
                              title: 'In progress',
                              count: getCount('in progress'),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            CardBox(
                              title: 'Resolved',
                              count: getCount('resolved'),
                            ),
                            SizedBox(width: 10),
                            CardBox(
                              title: 'Pending',
                              count: getCount('pending'),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Highest Priority Complaints',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.left,
                        ),

                        //Urgent Issues List
                        ListView.builder(
                          itemBuilder: (context, index) {
                            var complaint = topComplaints[index];

                            return IssueCard(
                              complaint: complaint,
                              onTap: () {
                                toComplaintDetails(complaint);
                              },
                            );
                          },
                          itemCount: isComplaintsLoading
                              ? 0
                              : topComplaints.length,
                          shrinkWrap: true,

                          physics: NeverScrollableScrollPhysics(),
                        ),
                        SizedBox(height: 10),
                        const Divider(thickness: 1, color: Colors.grey),
                        QuickButton(
                          title: 'View All Complaints',
                          icon: Icons.list_sharp,
                          onTap: () async {
                            final response = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => AdminComplaint(),
                              ),
                            );
                            if (response == true) {
                              fetchComplaints();
                            }
                          },
                        ),
                        QuickButton(
                          title: 'Approve Request',
                          icon: Icons.person_add_alt,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => Approval()),
                            );
                          },
                        ),
                        QuickButton(
                          title: 'Send Announcement',
                          icon: Icons.send_outlined,
                          onTap: () {},
                        ),
                        QuickButton(
                          title: 'Insights',
                          icon: Icons.insights_outlined,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => AdminInsights(),
                              ),
                            );
                          },
                        ),
                        const Divider(thickness: 1, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
