import 'package:client/screens/admin/widget/issue_card.dart';
import 'package:client/screens/admin/widget/quick_button.dart';
import 'package:client/screens/hosteller/complaint_details.dart';
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

  void toComplaintDetails(Map<String, dynamic> complaint) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ComplaintDetails(complaint: complaint),
      ),
    );
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

    return Scaffold(
      body: (isAdminLoading || isComplaintsLoading)
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
                            count: getCount('In progress'),
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
                          CardBox(title: 'Pending', count: getCount('pending')),
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
                          var complaint = _complaints[index];

                          return complaint?['type'] == "public" &&
                                  complaint?['status'] == "pending"
                              ? IssueCard(
                                  complaint: complaint,
                                  onTap: () {
                                    toComplaintDetails(complaint);
                                  },
                                )
                              : Container();
                        },
                        itemCount: isComplaintsLoading
                            ? 0
                            : (_complaints.length >= 3
                                  ? 3
                                  : _complaints.length),
                        shrinkWrap: true,

                        physics: NeverScrollableScrollPhysics(),
                      ),
                      SizedBox(height: 10),
                      const Divider(thickness: 1, color: Colors.grey),
                      QuickButton(
                        title: 'View All Complaints',
                        icon: Icons.list_sharp,
                        onTap: () {},
                      ),
                      QuickButton(
                        title: 'Insights',
                        icon: Icons.insights_outlined,
                        onTap: () {},
                      ),
                      QuickButton(
                        title: 'Send Announcement',
                        icon: Icons.send_outlined,
                        onTap: () {},
                      ),
                      const Divider(thickness: 1, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
