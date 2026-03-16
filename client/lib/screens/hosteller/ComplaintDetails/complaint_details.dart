// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:client/screens/hosteller/ComplaintDetails/delete_dialog.dart';
import 'package:client/screens/hosteller/ComplaintDetails/down_vote_button.dart';
import 'package:client/screens/hosteller/ComplaintDetails/pop_menu.dart';
import 'package:client/screens/hosteller/ComplaintDetails/up_vote_button.dart';
import 'package:client/screens/hosteller/ComplaintDetails/vote_count.dart';
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
  bool isLoading = false;
  bool isAdminLoading = true;
  bool isCheckVotesLoading = true;

  bool isUpvoted = false;
  bool isDownvoted = false;

  bool hasUpdated = false;
  int upvoteCount = 0;

  int downvoteCount = 0;
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
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response["message"],
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
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

  void _deleteUserComplaint() async {
    Api api = Api();
    final response = await api.deleteUserComplaint(widget.complaint['_id']);
    if (!mounted) return;
    debugPrint(response.toString());
    if (response['success'] == "true" || response['success'] == true) {
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response["message"],
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
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

  void patchRemarks(String remarks, String id) async {
    Api api = Api();
    final response = await api.editRemarks(remarks, id);
    if (response['success'] == true || response['success'] == "true") {
      setState(() {
        widget.complaint['adminRemarks'] = remarks;
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response['message'] ?? "Remark added",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
      setState(() {
        hasUpdated = true;
      });
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            response['message'] ?? "error occured",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 15),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
    }
  }

  Future<void> _changeStatus(String status) async {
    Api api = Api();
    final response = await api.editStatus(status, widget.complaint['_id']);
    if (!mounted) return;
    if (response['success'] == "true" || response["success"] == true) {
      setState(() {
        widget.complaint['status'] = status;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Status updated Successfully',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),
          backgroundColor: AppColors.bgLight,
        ),
      );
      setState(() {
        hasUpdated = true;
      });
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

  Future<void> handleUpVote() async {
    Votes vote = Votes(complaintId: widget.complaint['_id']);
    setState(() {
      isLoading = true;
    });
    final response = await vote.upVote();
    setState(() {
      isLoading = false;
    });
    if (!mounted) return;
    if (response['message'] == "Vote updated") {
      setState(() {
        votes = response;
        isUpvoted = true;
        isDownvoted = false;
        hasUpdated = true;
      });
      ScaffoldMessenger.of(context).clearSnackBars();
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
      debugPrint('UpVoted Successfully');
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
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
  }

  Future<void> handleDownVote() async {
    Votes vote = Votes(complaintId: widget.complaint['_id']);
    setState(() {
      isLoading = true;
    });
    final response = await vote.downVote();
    setState(() {
      isLoading = false;
    });
    if (!mounted) return;
    if (response['message'] == "Vote updated") {
      setState(() {
        votes = response;
        isDownvoted = true;
        isUpvoted = false;
        hasUpdated = true;
      });

      ScaffoldMessenger.of(context).clearSnackBars();
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
      debugPrint('Down Voted Successfully');
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
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

  Future<double> _getNetworkImageRatio(String url) async {
    final image = Image.network(url);
    final completer = Completer<ImageInfo>();

    image.image
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            completer.complete(info);
          }),
        );

    final imageInfo = await completer.future;
    return imageInfo.image.width / imageInfo.image.height;
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          Navigator.pop(context, hasUpdated);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.complaint['title'],
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
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
                                    if (user?['role'] == "admin")
                                      StatusBadgeMenu(
                                        status: toUpperCamelCase(
                                          widget.complaint['status'],
                                        ),
                                        onStatusChanged: (value) {
                                          _changeStatus(value);
                                        },
                                      )
                                    else
                                      _statusBadge(
                                        toUpperCamelCase(
                                          widget.complaint['status'],
                                        ),
                                      ),
                                    SizedBox(width: 6),
                                    _priorityBadge(
                                      toUpperCamelCase(
                                        "Block : ${widget.complaint['createdBy']['hostelBlock'] ?? "Undefined"}",
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
                      if (widget.complaint['images'].length != 0) ...[
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.4),
                            ),
                          ),
                          child: FutureBuilder(
                            future: _getNetworkImageRatio(
                              widget.complaint['images'][0],
                            ),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const SizedBox(
                                  height: 200,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return AspectRatio(
                                aspectRatio: snapshot.data!,
                                child: Image.network(
                                  widget.complaint['images'][0],
                                  fit: BoxFit.contain,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          //reported by
                          Text(
                            'Reported By : ',

                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(
                            Icons.person,
                            size: 24,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          SizedBox(width: 3),
                          Text(
                            widget.complaint['createdBy']['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      widget.complaint['adminRemarks'].toString().isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  'Admin Remarks :',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    widget.complaint['adminRemarks'],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 18),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
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
                                  onTap: handleUpVote,
                                ),
                                SizedBox(width: 10),

                                DownVoteButton(
                                  isDownVoted: isDownvoted,
                                  onTap: handleDownVote,
                                ),
                              ],
                            ),
                      SizedBox(height: 10),
                      user?['role'] == "admin"
                          ? Column(
                              children: [
                                widget.complaint['adminRemarks']
                                        .toString()
                                        .isNotEmpty
                                    ? SizedBox()
                                    : Column(
                                        children: [
                                          TextField(
                                            controller: _remarksController,
                                            maxLength: 200,
                                            maxLines: null,
                                            keyboardType:
                                                TextInputType.multiline,
                                            textInputAction:
                                                TextInputAction.newline,
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
                                                onPressed: () {
                                                  patchRemarks(
                                                    _remarksController.text,
                                                    widget.complaint['_id'],
                                                  );
                                                },
                                                child: Text('Post Remarks'),
                                              ),
                                            ],
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
            if (isLoading || isAdminLoading || isCheckVotesLoading)
              Container(
                color: Colors.black54,
                child: const Center(child: CircularProgressIndicator()),
              ),
          ],
        ),

        bottomNavigationBar:
            isAdminLoading && user?['role'] == "admin" ||
                widget.complaint['createdBy']['email'] == user?['email']
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
                            ),
                          );
                          if (response == true) {
                            user?['role'] == "admin"
                                ? _deleteComplaint()
                                : _deleteUserComplaint();
                          }
                        },
                        child: const Text('Delete'),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox(),
      ),
    );
  }
}
