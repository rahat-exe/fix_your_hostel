import 'package:client/screens/hosteller/complaint_details.dart';
import 'package:flutter/material.dart';
import 'package:client/widgets/raise_card.dart';
import 'package:client/util/user_storage.dart';
import 'package:client/services/api.dart';

class MyIssues extends StatefulWidget {
  const MyIssues({super.key});

  @override
  State<MyIssues> createState() => _MyIssuesState();
}

class _MyIssuesState extends State<MyIssues> {
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
    });
    print("user data loged :${userData.toString()}");
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Issues')),
      body: Center(
        child: Column(
          children: [
            for (final complaint in _complaints)
              if (complaint['createdBy']['name'] == user?['name'])
                RaiseCard(
                  title: complaint?['title'] ?? 'No Title',
                  description: complaint?['description'] ?? 'No Description',
                  raiser: complaint?['createdBy']['name'] ?? 'Unknown',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ComplaintDetails(
                          title: complaint['title'],
                          description: complaint['description'],
                          raisedBy: complaint['createdBy']['name'] ?? 'Unknown',
                        ),
                      ),
                    );
                  },
                ),
          ],
        ),
      ),
    );
  }
}
