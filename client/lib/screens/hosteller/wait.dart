import 'package:client/screens/hosteller/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:client/util/user_storage.dart';

class Wait extends StatefulWidget {
  const Wait({super.key});

  @override
  State<Wait> createState() => _WaitState();
}

class _WaitState extends State<Wait> {
  Map<String, dynamic>? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  Future<void> loadUser() async {
    final userData = await UserStorage.getUser();
    setState(() {
      user = userData;
    });
  }

  bool get isApproved =>
      user?['isApproved'] == true || user?['isApproved'] == "true";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isApproved
                        ? Icons.check_circle_outline
                        : Icons.hourglass_empty,
                    size: 70,
                    color: isApproved ? Colors.green : Colors.orange,
                  ),

                  const SizedBox(height: 25),

                  Text(
                    isApproved
                        ? "You are Approved!"
                        : "Waiting for Admin Approval",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    isApproved
                        ? "Redirecting you to the dashboard..."
                        : "Your account is under review.\nPlease wait until the admin approves it.\nPlease chceck again within 24 hours..",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  const SizedBox(height: 25),

                  isApproved
                      ? const ProgressIndicatoring()
                      : const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
