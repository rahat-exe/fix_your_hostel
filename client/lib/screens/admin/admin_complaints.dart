import 'package:client/screens/admin/widget/issue_card.dart';
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
    var data = await api.getComplaints();
    setState(() {
      _complaints = data;
      isComplaintsLoading = false;
    });
  }

  List<String> selectedBlocks = [];
  String selectedVisibility = "all";
  String selectedSort = "recent";

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
              child: SingleChildScrollView(
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
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Wrap(
                      spacing: 8,
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
                          selectedColor: Theme.of(
                            context,
                          ).colorScheme.onSurface, // 🔥 selected color
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
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Column(
                      children: [
                        RadioListTile(
                          value: "all",
                          groupValue: selectedVisibility,
                          title: const Text("All"),
                          onChanged: (value) {
                            setModalState(() {
                              selectedVisibility = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          value: "public",
                          groupValue: selectedVisibility,
                          title: const Text("Public"),
                          onChanged: (value) {
                            setModalState(() {
                              selectedVisibility = value!;
                            });
                          },
                        ),
                        RadioListTile(
                          value: "private",
                          groupValue: selectedVisibility,
                          title: const Text("Private"),
                          onChanged: (value) {
                            setModalState(() {
                              selectedVisibility = value!;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Sort By",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Column(
                      children: [
                        _sortTile("recent", "Most Recent", setModalState),
                        _sortTile("status", "Status", setModalState),
                        _sortTile("priority", "Priority", setModalState),
                        _sortTile("votes", "Highest Votes", setModalState),
                        _sortTile("oldest", "Oldest First", setModalState),
                      ],
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).scaffoldBackgroundColor,
                        ),
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(context);
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
              child: SingleChildScrollView(
                child: isComplaintsLoading
                    ? Center(child: CircularProgressIndicator())
                    : _complaints.isEmpty
                    ? Center(
                        child: Text(
                          'No Complaints Reported Yet',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          for (final complaint in _complaints)
                            IssueCard(complaint: complaint, onTap: () {}),
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
