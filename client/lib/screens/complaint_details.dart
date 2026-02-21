import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(15),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reported Complaint ',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
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
                  ElevatedButton(
                    onPressed: () {},

                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      fixedSize: Size(150, 50),
                    ),
                    child: Text(
                      'UpVote',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      fixedSize: Size(150, 50),
                    ),
                    child: Text(
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
