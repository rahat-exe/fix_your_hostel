import 'package:client/screens/admin/widget/issue_card.dart';
import 'package:client/screens/hosteller/ComplaintDetails/complaint_details.dart';
import 'package:client/screens/hosteller/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:client/services/api.dart';

class AdminComplaint extends StatefulWidget {
  const AdminComplaint({super.key});

  @override
  State<AdminComplaint> createState() => _AdminComplaintState();
}

class _AdminComplaintState extends State<AdminComplaint> {
  bool isComplaintsLoading = true;
  List<dynamic> _complaints = [];
  @override
  void initState() {
    super.initState();
    fetchComplaints();
  }

  void fetchComplaints() async {
    Api api = Api();
    var data = await api.getComplaints(
      type: selectedVisibility == "all" ? null : selectedVisibility,
      status: selectedStatus == "all" ? null : selectedStatus,
    );
    setState(() {
      _complaints = data;
      isComplaintsLoading = false;
    });
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

  List<String> selectedBlocks = [];
  String selectedVisibility = "all";
  String selectedSort = "recent";
  String selectedStatus = "all";
  final List<String> blocks = ["Block A", "Block B", "Block C", "Block D"];

  void _openFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Filter & Sort",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 20),

                              const Text(
                                "Filter by Hostel Block",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 10,
                                children: blocks.map((block) {
                                  return FilterChip(
                                    label: Text(
                                      block,
                                      selectionColor: Theme.of(
                                        context,
                                      ).colorScheme.onSurface,
                                    ),
                                    selected: selectedBlocks.contains(block),
                                    backgroundColor: Theme.of(
                                      context,
                                    ).scaffoldBackgroundColor,
                                    selectedColor: Theme.of(context)
                                        .colorScheme
                                        .onSurface, // 🔥 selected color
                                    checkmarkColor: Theme.of(
                                      context,
                                    ).scaffoldBackgroundColor,
                                    side: BorderSide(
                                      color: selectedBlocks.contains(block)
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                    onSelected: (value) {
                                      setModalState(() {
                                        if (value) {
                                          selectedBlocks.add(block);
                                        } else {
                                          selectedBlocks.remove(block);
                                        }
                                      });
                                    },
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                "Visibility",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),

                              Column(
                                spacing: 10,
                                children: [
                                  RadioGroup<String>(
                                    groupValue: selectedVisibility,
                                    onChanged: (value) {
                                      setModalState(() {
                                        selectedVisibility = value!;
                                      });
                                    },
                                    child: Column(
                                      spacing: 0,
                                      children: const [
                                        RadioListTile(
                                          value: "all",
                                          title: Text("All"),
                                        ),
                                        RadioListTile(
                                          value: "public",
                                          title: Text("Public"),
                                        ),
                                        RadioListTile(
                                          value: "private",
                                          title: Text("Private"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                "Status",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),

                              Column(
                                children: [
                                  RadioGroup<String>(
                                    groupValue: selectedStatus,
                                    onChanged: (value) {
                                      setModalState(() {
                                        selectedStatus = value!;
                                      });
                                    },
                                    child: Column(
                                      children: const [
                                        RadioListTile(
                                          value: "all",
                                          title: Text("All"),
                                        ),
                                        RadioListTile(
                                          value: "pending",
                                          title: Text("Pending"),
                                        ),
                                        RadioListTile(
                                          value: "in progress",
                                          title: Text("In Progress"),
                                        ),
                                        RadioListTile(
                                          value: "resolved",
                                          title: Text("Resolved"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              const Text(
                                "Sort By",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                ),
                              ),

                              Column(
                                children: [
                                  _sortTile(
                                    "recent",
                                    "Most Recent",
                                    setModalState,
                                  ),
                                  _sortTile(
                                    "priority",
                                    "Priority",
                                    setModalState,
                                  ),
                                  _sortTile(
                                    "votes",
                                    "Highest Votes",
                                    setModalState,
                                  ),
                                  _sortTile(
                                    "oldest",
                                    "Oldest First",
                                    setModalState,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).scaffoldBackgroundColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          fetchComplaints();
                        },
                        child: const Text("Apply"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _sortTile(String value, String label, Function setModalState) {
    return RadioListTile(
      value: value,
      groupValue: selectedSort,
      title: Text(label),
      onChanged: (val) {
        setModalState(() {
          selectedSort = val!;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            /// HEADER ROW
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Complaints",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  color: Theme.of(context).colorScheme.onSurface,
                  onPressed: _openFilterSheet,
                ),
              ],
            ),

            /// LIST SECTION
            Expanded(
              child: isComplaintsLoading
                  ? ProgressIndicatoring()
                  : _complaints.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      child: Text(
                        'No Complaints Found',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          for (final complaint in _complaints)
                            IssueCard(
                              complaint: complaint,
                              onTap: () {
                                toComplaintDetails(complaint);
                              },
                            ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
