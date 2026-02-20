import 'package:flutter/material.dart';

class AddIssue extends StatefulWidget {
  const AddIssue({super.key});
  @override
  State<AddIssue> createState() {
    return _AddIssue();
  }
}

class _AddIssue extends State<AddIssue> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List your issues', style: TextStyle(fontSize: 20)),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                maxLength: 30,
                decoration: InputDecoration(
                  label: Text('Issue title'),

                  hintText: 'Enter the Issue title',
                ),
              ),

              TextFormField(
                maxLength: 200,
                maxLines: null, // 👈 allows unlimited lines
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  label: Text('Description'),
                  hintText: 'Describe the issue within 200 words',
                  alignLabelWithHint: true, // 👈 keeps label aligned at top
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  fixedSize: Size(320, 50),
                  textStyle: TextStyle(fontSize: 20),
                ),
                child: Text('Add Image'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(fixedSize: Size(120, 30)),
                      child: Text('Submit'),
                    ),
                    SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.onPrimary,
                        fixedSize: Size(120, 30),
                      ),
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
