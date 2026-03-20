import 'package:client/class/issues.dart';
import 'package:client/screens/dialog_box.dart';
import 'package:client/screens/hosteller/widgets/image_input.dart';
import 'package:client/services/api.dart';
import 'package:client/util/user_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AddIssue extends StatefulWidget {
  const AddIssue({super.key});

  @override
  State<AddIssue> createState() {
    return _AddIssue();
  }
}

class _AddIssue extends State<AddIssue> {
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
  Categories? selectedCategory;
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
    if (selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please add the image')));
      return;
    }
    setState(() {
      isLoading = true;
    });

    final response = await Api.addComplaint({
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "type": "private",
      "image": selectedImage,
      "category": selectedCategory?.name,
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

  Future<double> _getImageRatio(File file) async {
    final decodedImage = await decodeImageFromList(await file.readAsBytes());
    return decodedImage.width / decodedImage.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List your issues', style: TextStyle(fontSize: 20)),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Form(
                key: _form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: titleController,
                      maxLength: 30,
                      style: TextStyle(),
                      decoration: InputDecoration(
                        label: Text('Issue title'),
                        hintText: 'Enter the Issue title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Title cannot be empty';
                        }
                        return null;
                      },
                    ),

                    TextFormField(
                      maxLength: 200,
                      controller: descriptionController,
                      maxLines: null, // 👈 allows unlimited lines
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      decoration: InputDecoration(
                        label: Text('Description'),
                        hintText: 'Describe the issue within 200 words',
                        alignLabelWithHint:
                            true, // 👈 keeps label aligned at top
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Description cannot be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20),
                    DropdownButtonFormField<Categories>(
                      initialValue: selectedCategory,
                      dropdownColor: Theme.of(context).colorScheme.surface,
                      icon: Icon(
                        Icons.keyboard_arrow_down,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),

                      decoration: InputDecoration(
                        labelText: 'Category',

                        filled: true,
                        fillColor: Theme.of(context).colorScheme.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.white24),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.5,
                          ),
                        ),
                      ),
                      items: Categories.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.name.toLowerCase()),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          if (value == null) {
                            return;
                          }
                          selectedCategory = value;
                        });
                      },
                    ),
                    SizedBox(height: 20),
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
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
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

                    SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submit,
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          fixedSize: Size(120, 50),
                        ),

                        child: Text(
                          'Submit Issue',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer
                                .withValues(alpha: 0.8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 30),
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
      ),
    );
  }
}
