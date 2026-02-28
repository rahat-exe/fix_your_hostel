import 'package:client/screens/hosteller/widgets/progress_indicator.dart';
import 'package:client/theme/theme.dart';
import 'package:client/util/user_storage.dart';
import 'package:flutter/material.dart';
// import 'package:client/services/api.dart';

class ComplaintDetails extends StatefulWidget {
  const ComplaintDetails({super.key, required this.complaint});
  final Map<String, dynamic> complaint;
  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  Map<String, dynamic>? user;

  bool isAdminLoading = true;
  bool isVotesLoading = true;

  @override
  void initState() {
    fetchUser();

    super.initState();
  }

  void fetchUser() async {
    final userData = await UserStorage.getUser();
    setState(() {
      user = userData;
      isAdminLoading = false;
    });
  }

  bool isUpvoted = false;
  bool isDownvoted = false;
  int upvoteCount = 0;
  int downvoteCount = 0;

  Future<void> handleUpVote() async {
    setState(() {
      isUpvoted = true;
    });
  }

  Future<void> handleDownVote() async {
    setState(() {
      isDownvoted = true;
    });
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
          'Reported Complaint',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: isAdminLoading
          ? ProgressIndicatoring()
          : SafeArea(
              child: Container(
                padding: EdgeInsets.all(15),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.complaint['title'],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        //badges
                        Row(
                          children: [
                            _statusBadge(
                              toUpperCamelCase(widget.complaint['status']),
                            ),
                            SizedBox(width: 6),
                            _priorityBadge(
                              toUpperCamelCase(widget.complaint['priority']),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10),
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
                    //buttons
                    user?['role'] == "admin"
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                      border: BoxBorder.all(
                                        color: AppColors.border,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Upvotes :',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          widget.complaint['upvotes'] != null
                                              ? widget
                                                    .complaint['upvotes']
                                                    .length
                                                    .toString()
                                              : '0',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                      border: BoxBorder.all(
                                        color: AppColors.border,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'DownVotes :',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          widget.complaint['downvotes'] != null
                                              ? widget
                                                    .complaint['downvotes']
                                                    .length
                                                    .toString()
                                              : '0',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: isUpvoted || isDownvoted
                                    ? () {}
                                    : handleUpVote,

                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isUpvoted || isDownvoted
                                      ? Theme.of(context).colorScheme.surface
                                            .withValues(alpha: 0.6)
                                      : Theme.of(context).colorScheme.surface,

                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surface,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  minimumSize: Size(150, 50),
                                ),
                                child: isUpvoted
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'UpVoted',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.5),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.arrow_upward_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.5),
                                            size: 25,
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'UpVote',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.9),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.arrow_upward_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.9),
                                            size: 25,
                                          ),
                                        ],
                                      ),
                              ),
                              SizedBox(width: 10),

                              ElevatedButton(
                                onPressed: isDownvoted || isUpvoted
                                    ? () {}
                                    : handleDownVote,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isDownvoted || isUpvoted
                                      ? Theme.of(context).colorScheme.surface
                                            .withValues(alpha: 0.5)
                                      : Theme.of(context).colorScheme.surface,
                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.surface,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  minimumSize: Size(150, 50),
                                ),
                                child: isDownvoted
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'DownVoted',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.5),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.arrow_downward_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.5),
                                            size: 25,
                                          ),
                                        ],
                                      )
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            'DownVote',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface
                                                  .withValues(alpha: 0.9),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Icon(
                                            Icons.arrow_downward_outlined,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onSurface
                                                .withValues(alpha: 0.9),
                                            size: 25,
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 22, horizontal: 10),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Update'),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Delete'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
