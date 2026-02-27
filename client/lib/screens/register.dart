import 'package:client/screens/admin/tabs.dart';
import 'package:client/screens/hosteller/home.dart';
import 'package:client/util/user_storage.dart';
import 'package:flutter/material.dart';
import 'package:client/services/auth.dart';
import 'package:client/util/token_storage.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _Register();
}

class _Register extends State<Register> {
  final _form = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();

  TextEditingController passController = TextEditingController();

  TextEditingController confirmPassController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController rollNoController = TextEditingController();

  TextEditingController hostelBlockController = TextEditingController();

  TextEditingController roomNoController = TextEditingController();
  bool hidePassword = true;
  bool isLogin = true;
  void _submit() async {
    final isValidated = _form.currentState!.validate();
    if (!isValidated) {
      return;
    }
    _form.currentState!.save();
    // Perform login or registration logic here
    if (isLogin) {
      final credentials = {
        'email': emailController.text.trim(),
        'password': passController.text.trim(),
      };
      final response = await Auth.login(credentials);

      if (response.isNotEmpty) {
        await TokenStorage.save(response["token"]);
        await UserStorage.saveUser(response["user"]);

        if (!mounted) return;
        if (response['user']['role'] == 'admin') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Tabs()),
          );
          return;
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Login failed. Please check your credentials.'),
          ),
        );
      }
    } else {
      final userCredentials = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passController.text.trim(),
        // 'rollNo': rollNoController.text.trim(),
        'hostelBlock': hostelBlockController.text.trim(),
        'roomNo': roomNoController.text.trim(),
      };

      final response = await Auth.register(userCredentials);
      print(response);
      if (response.isNotEmpty) {
        await TokenStorage.save(response["token"]);
        await UserStorage.saveUser(response["user"]);
        setState(() {
          isLogin = true;
        });
        return;
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed. Please try again.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                margin: EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(8),
                    child: Form(
                      key: _form,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // if (!isLogin)
                          //   ImageInput(
                          //     onSelectImage: (pickedImage) {
                          //       _selectedImage = pickedImage;
                          //     },
                          //   ),
                          //name
                          TextFormField(
                            controller: nameController,
                            decoration: InputDecoration(label: Text('Name')),
                            enableSuggestions: false,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.length < 4) {
                                return 'Username must contain atleast 4 characters';
                              }
                              return null;
                            },
                          ),
                          //email
                          TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              label: Text('Email address'),
                            ),
                            autocorrect: false,
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                          ),
                          //password
                          TextFormField(
                            controller: passController,
                            decoration: InputDecoration(
                              label: Text('Password'),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  hidePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    hidePassword = !hidePassword;
                                  });
                                },
                              ),
                            ),
                            autocorrect: false,
                            obscureText: hidePassword,
                            validator: (value) {
                              if (value == null || value.length < 6) {
                                return 'Password length must be above 6';
                              }
                              return null;
                            },
                          ),
                          //confirm password
                          if (!isLogin)
                            TextFormField(
                              controller: confirmPassController,
                              decoration: InputDecoration(
                                label: Text('Confirm Password'),
                              ),
                              autocorrect: false,
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password is empty';
                                }
                                if (value != passController.text) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          //roll no
                          if (!isLogin)
                            TextFormField(
                              controller: rollNoController,
                              decoration: InputDecoration(
                                label: Text('Roll No'),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Enter a valid roll number';
                                }
                                return null;
                              },
                            ),
                          //hostel block
                          if (!isLogin)
                            TextFormField(
                              controller: hostelBlockController,
                              decoration: InputDecoration(
                                label: Text('Hostel Block'),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Enter a valid hostel block';
                                }
                                return null;
                              },
                            ),
                          //room no
                          if (!isLogin)
                            TextFormField(
                              controller: roomNoController,
                              decoration: InputDecoration(
                                label: Text('Room No'),
                              ),
                              autocorrect: false,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Enter a valid room number';
                                }
                                return null;
                              },
                            ),
                          SizedBox(height: 10),

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(
                                context,
                              ).colorScheme.primary,
                            ),
                            onPressed: _submit,
                            child: Text(
                              isLogin ? 'Login' : 'Sign Up',
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSecondary,
                                  ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(
                              isLogin
                                  ? 'Create an account'
                                  : 'Already have an account',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
