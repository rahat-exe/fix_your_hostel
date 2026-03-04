// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:client/screens/hosteller/ComplaintDetails/delete_dialog.dart';
import 'package:client/screens/hosteller/ComplaintDetails/down_vote_button.dart';
import 'package:client/screens/hosteller/ComplaintDetails/up_vote_button.dart';
import 'package:client/screens/hosteller/ComplaintDetails/vote_count.dart';
import 'package:client/screens/hosteller/widgets/progress_indicator.dart';
import 'package:client/services/api.dart';
import 'package:client/services/votes.dart';
import 'package:client/theme/theme.dart';
import 'package:client/util/user_storage.dart';
import 'package:flutter/material.dart';
//import 'package:client/services/api.dart';

class ComplaintDetails extends StatefulWidget {
  const ComplaintDetails({super.key, required this.complaint});
  final Map<String, dynamic> complaint;

  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  Map<String, dynamic>? user;
  bool isAdminLoading = true;
  bool isCheckVotesLoading = true;
  bool isUpvoted = false;
  bool isDownvoted = false;

  Map<String, dynamic>? votes;
  late TextEditingController _remarksController;

  @override
  void initState() {
    _remarksController = TextEditingController();
    fetchUser();
    super.initState();
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  void fetchUser() async {
    final userData = await UserStorage.getUser();
    setState(() {
      user = userData;
      isAdminLoading = false;
    });
    checkVoteStatus();
  }

  void _deleteComplaint() async {
    Api api = Api();
    final response = await api.deleteComplaint(widget.complaint['_id']);
    if (!mounted) return;
    debugPrint(response.toString());
    if (response['success'] == "true" || response['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response["message"],
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 20),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response['message'] ?? "Error occured",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
    }
  }

  void checkVoteStatus() {
    final List<dynamic> upVotes =
        widget.complaint['upvotes'] as List<dynamic>? ?? [];
    final List<dynamic> downVotes =
        widget.complaint['downvotes'] as List<dynamic>? ?? [];
    final userId = user?['id'];
    setState(() {
      isUpvoted = upVotes.contains(userId);
      isDownvoted = downVotes.contains(userId);
      isCheckVotesLoading = false;
    });
    debugPrint('Votes printed');
    debugPrint(upVotes.toString());
    debugPrint(downVotes.toString());
  }

  int upvoteCount = 0;
  int downvoteCount = 0;

  Future<void> handleUpVote() async {
    Votes vote = Votes(complaintId: widget.complaint['_id']);
    final response = await vote.upVote();
    if (!mounted) return;
    if (response['message'] == "Vote updated") {
      setState(() {
        votes = response;
        isUpvoted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Up Vote Registered Successfully',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            textAlign: TextAlign.center,
            'Error Occurred',
            style: TextStyle(color: Colors.white70),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
    }
    debugPrint(response.toString());
    debugPrint('UpVoted Successfully');
  }

  Future<void> handleDownVote() async {
    Votes vote = Votes(complaintId: widget.complaint['_id']);
    final response = await vote.downVote();
    if (!mounted) return;
    if (response['message'] == "Vote updated") {
      setState(() {
        votes = response;
        isDownvoted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Down Vote Registered Successfully',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Error Occurred',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
    }
    debugPrint(response.toString());
    debugPrint('Down Voted Successfully');
  }

  String toUpperCamelCase(String text) {
    return text
        .split(' ')
        .map(
          (word) => word.isNotEmpty
              ? word[0].toUpperCase() + word.substring(1).toLowerCase()
              : '',
        )
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    Widget _statusBadge(String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),

        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }

    Widget _priorityBadge(String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(text, style: const TextStyle(fontSize: 16)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.complaint['title'],
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: (isAdminLoading || isCheckVotesLoading)
          ? ProgressIndicatoring()
          : SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  padding: EdgeInsets.all(15),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //descriptions
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.complaint['description'],
                          style: Theme.of(
                            context,
                          ).textTheme.bodyMedium!.copyWith(fontSize: 18),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _statusBadge(
                                      toUpperCamelCase(
                                        widget.complaint['status'],
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    _priorityBadge(
                                      toUpperCamelCase(
                                        widget.complaint['priority'],
                                      ),
                                    ),
                                  ],
                                ),
                                if (widget.complaint['type'] == "private") ...[
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 4,
                                        ),
                                        child: Icon(
                                          Icons.lock_outline,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.onSurface,
                                          size: 23,
                                        ),
                                      ),
                                      SizedBox(width: 3),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 4,
                                          right: 3,
                                        ),
                                        child: Text(
                                          'Private',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(width: 10),

                          //badges
                        ],
                      ),
                      //Images
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        child: Text(
                          'Images section',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //reported by
                          Text(
                            'Reported By : ',

                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.person,
                            size: 28,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          SizedBox(width: 3),
                          Text(
                            widget.complaint['createdBy']['name'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      //admin side vote counts
                      user?['role'] == "admin" &&
                              widget.complaint['type'] != "private"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    VoteCount(
                                      title: 'Up Votes:',
                                      votes: widget.complaint['upvotes'],
                                    ),
                                    SizedBox(width: 10),
                                    VoteCount(
                                      title: 'Down Votes :',
                                      votes: widget.complaint['downvotes'],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : widget.complaint['type'] == "private"
                          ? SizedBox()
                          : //cast vote buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                UpVoteButton(
                                  isUpvoted: isUpvoted,
                                  isDownVoted: isDownvoted,
                                  onTap: handleUpVote,
                                ),
                                SizedBox(width: 10),

                                DownVoteButton(
                                  isUpvoted: isUpvoted,
                                  isDownVoted: isDownvoted,
                                  onTap: handleDownVote,
                                ),
                              ],
                            ),
                      SizedBox(height: 10),
                      user?['role'] == "admin"
                          ? Column(
                              children: [
                                TextField(
                                  controller: _remarksController,
                                  maxLength: 200,
                                  maxLines: null,
                                  keyboardType: TextInputType.multiline,
                                  textInputAction: TextInputAction.newline,
                                  decoration: const InputDecoration(
                                    labelText: 'Admin Remarks',

                                    alignLabelWithHint: true,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Text('Post Remarks'),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),

      bottomNavigationBar: user?['role'] == "admin"
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 22, horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final response = await showDialog(
                          context: context,
                          builder: (context) => DeleteDialog(
                            title: "Delete Complaint",
                            message:
                                "Are you sure you want to delete this complaint",
                            onConfirm: _deleteComplaint,
                          ),
                        );
                        if (response == true) {
                          _deleteComplaint();
                        }
                      },
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            )
          : SizedBox(),
    );
  }
}
