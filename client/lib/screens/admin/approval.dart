import 'package:client/screens/hosteller/widgets/progress_indicator.dart';
import 'package:client/services/user.dart';
import 'package:flutter/material.dart';

class Approval extends StatefulWidget {
  const Approval({super.key});

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  bool isUserLoading = true;
  // Mock data: In a real app, this would come from Firebase or an API
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  List<Map<String, dynamic>> users = [];
  void fetchUsers() async {
    UserApi api = UserApi();
    final response = await api.getAllUsers();

    if (!mounted) return;

    if (response.isNotEmpty &&
        (response['success'] == true || response['success'] == "true")) {
      setState(() {
        users = List<Map<String, dynamic>>.from(response['data']);
        isUserLoading = false;
      });
    } else {
      setState(() {
        isUserLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Approve Requests'), centerTitle: true),
      body: isUserLoading
          ? ProgressIndicatoring()
          : users.isEmpty
          ? const Center(child: Text("No pending requests"))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final student = users[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    title: Text(
                      student['name']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('Room: ${student['room']} '),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize:
                          MainAxisSize.min, // Essential for Row in trailing
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.red),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
