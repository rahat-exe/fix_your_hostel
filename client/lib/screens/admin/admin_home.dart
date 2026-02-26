import 'package:client/screens/admin/widget/issue_card.dart';
import 'package:client/screens/admin/widget/quick_button.dart';
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
  List<dynamic> _complaints = [];
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
    });
  }

  void fetchComplaints() async {
    Api api = Api();
    var data = await api.getComplaints();
    setState(() {
      _complaints = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    const spacing = 12.0; // SizedBox width between cards

    return Scaffold(
      body: SingleChildScrollView(
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
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                // Cards Section
                Row(
                  children: [
                    CardBox(title: 'Total Issues', count: 100),
                    SizedBox(width: spacing),
                    CardBox(title: 'In progress', count: 20),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    CardBox(title: 'Resolved', count: 40),
                    SizedBox(width: 10),
                    CardBox(title: 'Pending', count: 30),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Highest Priority Complaints',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),

                //Urgent Issues List
                ListView.builder(
                  itemBuilder: (context, index) {
                    var complaint = _complaints[index];

                    return complaint['type'] == "public"
                        ? IssueCard(
                            title: complaint?['title'],
                            description: complaint?['description'],
                            raiser: complaint?['createdBy']['name'],
                            onTap: () {},
                          )
                        : Container();
                  },
                  itemCount: 3,
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
