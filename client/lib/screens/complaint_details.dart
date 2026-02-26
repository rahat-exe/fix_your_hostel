import 'package:flutter/material.dart';
// import 'package:client/services/api.dart';

class ComplaintDetails extends StatefulWidget {
  const ComplaintDetails({
    super.key,
    required this.title,
    required this.description,
    required this.raisedBy,
  });
  final String title;
  final String description;
  final String raisedBy;
  @override
  State<ComplaintDetails> createState() => _ComplaintDetailsState();
}

class _ComplaintDetailsState extends State<ComplaintDetails> {
  bool isUpvoted = false;
  bool isDownvoted = false;
  int upvoteCount = 0;
  int downvoteCount = 0;
  bool voteLoading = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reported Complaint',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(8),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.9),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(17),
                child: Text('Images section', style: TextStyle(fontSize: 20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Raised By : ',

                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.person,
                    size: 28,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  SizedBox(width: 3),
                  Text(
                    widget.raisedBy,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: isUpvoted || isDownvoted ? () {} : handleUpVote,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: isUpvoted || isDownvoted
                          ? Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.6)
                          : Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      fixedSize: Size(150, 50),
                    ),
                    child: voteLoading
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          )
                        : isUpvoted
                        ? Text(
                            'UpVoted',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'UpVote',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: isDownvoted || isUpvoted
                        ? () {}
                        : handleDownVote,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isDownvoted || isUpvoted
                          ? Theme.of(
                              context,
                            ).colorScheme.error.withValues(alpha: 0.6)
                          : Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      fixedSize: Size(150, 50),
                    ),
                    child: voteLoading
                        ? SizedBox(
                            height: 30,
                            width: 30,
                            child: CircularProgressIndicator(),
                          )
                        : isDownvoted
                        ? Text(
                            'DownVoted',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            'DownVote',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
