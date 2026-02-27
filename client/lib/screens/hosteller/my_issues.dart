import 'package:client/screens/hosteller/complaint_details.dart';
import 'package:client/screens/hosteller/widgets/empty_list.dart';
import 'package:client/screens/hosteller/widgets/progress_indicator.dart';
import 'package:client/screens/hosteller/widgets/raise_card.dart';
import 'package:flutter/material.dart';

import 'package:client/util/user_storage.dart';
import 'package:client/services/api.dart';

class MyIssues extends StatefulWidget {
  const MyIssues({super.key});

  @override
  State<MyIssues> createState() => _MyIssuesState();
}

class _MyIssuesState extends State<MyIssues> {
  bool isUserLoading = true;
  bool isComplaintLoading = true;
  List<dynamic> _complaints = [];
  Map<String, dynamic>? user;
  @override
  void initState() {
    loadUser();
    fetchComplaints();

    super.initState();
  }

  Future<void> loadUser() async {
    var userData = await UserStorage.getUser();
    setState(() {
      user = userData;
      isUserLoading = false;
    });
    print("user data loged :${userData.toString()}");
  }

  void fetchComplaints() async {
    print('Fetching complaints from API...');
    Api api = Api();
    var data = await api.getComplaints();

    setState(() {
      _complaints = data;
      isComplaintLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a centered boxed loader while user or complaints are loading

    return Scaffold(
      appBar: AppBar(title: Text('My Issues')),
      body: (isComplaintLoading || isUserLoading)
          ? ProgressIndicatoring()
          : _complaints.isEmpty
          ? EmptyList(message: 'No Complaints Reported Yet')
          : SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    for (final complaint in _complaints)
                      if (complaint['createdBy']['name'] == user?['name'])
                        RaisedCard(
                          complaint: complaint,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComplaintDetails(
                                  title: complaint['title'],
                                  description: complaint['description'],
                                  raisedBy:
                                      complaint['createdBy']['name'] ??
                                      'Unknown',
                                ),
                              ),
                            );
                          },
                        ),
                  ],
                ),
              ),
            ),
    );
  }
}
