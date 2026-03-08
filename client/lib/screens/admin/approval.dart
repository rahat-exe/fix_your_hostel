import 'package:client/screens/dialog_box.dart';
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
        users = List<Map<String, dynamic>>.from(
          response['data'],
        ).where((user) => user['isApproved'] == false).toList();
        isUserLoading = false;
      });
    } else {
      setState(() {
        isUserLoading = false;
      });
    }
  }

  void approveUser(String id) async {
    UserApi api = UserApi();
    final response = await api.approveUser(id);

    if (!mounted) return;

    if (response.isNotEmpty &&
        (response['success'] == true || response['success'] == "true")) {
      showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            message: "User has been approved successfully!!",
            onTap: () {
              Navigator.pop(context);
              isUserLoading = true;
              fetchUsers();
            },
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: ${response['message']}')),
      );
    }
  }

  void deleteUser(String id) async {
    UserApi api = UserApi();
    final response = await api.deleteUser(id);
    if (!mounted) return;
    if (response.isNotEmpty &&
        (response['success'] == true || response['success'] == "true")) {
      showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            message: "User has been deleted successfully!!",
            onTap: () {
              Navigator.pop(context);
              isUserLoading = true;
              fetchUsers();
            },
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error occurred: ${response['message']}')),
      );
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

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 6,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TOP ROW
                          Row(
                            children: [
                              /// Name + email
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      student['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      student['email'],
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          /// DETAILS
                          Row(
                            children: [
                              const Icon(
                                Icons.badge,
                                size: 18,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 6),
                              Text("Roll No: ${student['rollNo'] ?? "N/A"}"),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [
                              const Icon(
                                Icons.apartment,
                                size: 18,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 6),
                              Text("Block: ${student['hostelBlock']}"),
                            ],
                          ),

                          const SizedBox(height: 6),

                          Row(
                            children: [
                              const Icon(
                                Icons.meeting_room,
                                size: 18,
                                color: Colors.white70,
                              ),
                              const SizedBox(width: 6),
                              Text("Room: ${student['roomNumber']}"),
                            ],
                          ),

                          const SizedBox(height: 16),

                          /// ACTION BUTTONS
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              /// Reject
                              OutlinedButton.icon(
                                onPressed: () {
                                  deleteUser(student['_id']);
                                },
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                label: const Text(
                                  "Reject",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),

                              const SizedBox(width: 10),

                              /// Approve
                              ElevatedButton.icon(
                                onPressed: () {
                                  approveUser(student['_id']);
                                },
                                icon: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  "Approve",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
