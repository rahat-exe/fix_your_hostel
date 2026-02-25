import 'package:client/class/issues.dart';
import 'package:client/services/api.dart';
import 'package:client/util/user_storage.dart';
import 'package:flutter/material.dart';

class AddIssue extends StatefulWidget {
  const AddIssue({super.key});
  @override
  State<AddIssue> createState() {
    return _AddIssue();
  }
}

class _AddIssue extends State<AddIssue> {
  Map<String, dynamic>? user;
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
    final response = await Api.addComplaint({
      "title": titleController.text.trim(),
      "description": descriptionController.text.trim(),
      "type": "public",
      "createdBy": user?['id'].toString() ?? "anonymous",
    });
    if (response != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Complaint submitted successfully!')),
      );
      Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List your issues', style: TextStyle(fontSize: 20)),
      ),
      body: SingleChildScrollView(
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
                    alignLabelWithHint: true, // 👈 keeps label aligned at top
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
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('Add Images'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white70,
                      side: BorderSide(color: Colors.white24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
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
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      fixedSize: Size(120, 50),
                    ),

                    child: Text(
                      'Submit Issue',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: Theme.of(
                          context,
                        ).colorScheme.onPrimaryContainer.withValues(alpha: 0.8),
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
    );
  }
}
