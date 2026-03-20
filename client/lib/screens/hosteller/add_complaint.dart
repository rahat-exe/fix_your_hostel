import 'dart:io';

import 'package:client/screens/dialog_box.dart';
import 'package:client/screens/hosteller/widgets/image_input.dart';
import 'package:client/services/api.dart';
import 'package:flutter/material.dart';
import 'package:client/util/user_storage.dart';

class AddComplaint extends StatefulWidget {
  const AddComplaint({super.key});

  @override
  State<AddComplaint> createState() => _AddComplaintState();
}

class _AddComplaintState extends State<AddComplaint> {
  bool isLoading = false;
  Map<String, dynamic>? user;
  File? selectedImage;

  @override
  initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    var userData = await UserStorage.getUser();
    setState(() {
      user = userData;
    });
    print("user data loged :${userData.toString()}");
  }

  final _form = GlobalKey<FormState>();
  bool isPrivate = false;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void _submit() async {
    var isValid = _form.currentState?.validate() ?? false;
    if (!isValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields correctly.'),
        ),
      );
      return;
    }
    setState(() {
      isLoading = true;
    });
    final response = await Api.addComplaint({
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "image": selectedImage,
      "type": isPrivate ? "private" : "public",
    });
    setState(() {
      isLoading = false;
    });
    if (response != null) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) {
          return DialogBox(
            message: "Complaint Submitted Successfully",
            onTap: () {
              Navigator.pop(context, true);
              Navigator.pop(context, true);
            },
          );
        },
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit complaint. Please try again.'),
        ),
      );
    }
  }

  Future<double> _getImageRatio(File file) async {
    final decodedImage = await decodeImageFromList(await file.readAsBytes());
    return decodedImage.width / decodedImage.height;
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: const [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Raise Hostel Complaint',
              style: TextStyle(fontSize: 20),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: titleController,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      labelText: 'Complaint Title',
                      hintText: 'Enter a short title',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Title cannot be empty';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: descriptionController,
                    maxLength: 200,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      hintText: 'Describe the issue in detail',
                      alignLabelWithHint: true,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Description cannot be empty';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Private Complaint',
                            style: theme.textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Visible only to hostel admin',
                            style: theme.textTheme.bodySmall!.copyWith(
                              color: Colors.white60,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: isPrivate,
                        onChanged: (value) {
                          setState(() {
                            isPrivate = value;
                          });
                        },
                        activeThumbColor: theme.colorScheme.primary,
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  if (selectedImage != null) ...[
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
                        future: _getImageRatio(selectedImage!),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const SizedBox(
                              height: 200,
                              child: Center(child: CircularProgressIndicator()),
                            );
                          }

                          return AspectRatio(
                            aspectRatio: snapshot.data!,
                            child: Image.file(
                              selectedImage!,
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                  ],

                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ImageInput(
                      onSelectImage: (value) {
                        setState(() {
                          selectedImage = value;
                        });
                      },
                    ),
                  ),

                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Text(
                        'Submit Complaint',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // 🔹 Cancel (Tertiary)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (isLoading)
          Container(
            color: Colors.black54,
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
