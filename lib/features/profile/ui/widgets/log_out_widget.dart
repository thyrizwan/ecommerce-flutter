import 'package:ecommerce/app/shared_preference_helper.dart';
import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class LogOutWidget extends StatefulWidget {
  // final VoidCallback onLogout;
  const LogOutWidget({
    super.key,
    // required this.onLogout,
  });

  @override
  State<LogOutWidget> createState() => _LogOutWidgetState();
}

class _LogOutWidgetState extends State<LogOutWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        await SharedPreferenceHelper.clearAllData();
        setState(() {});
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              SignInScreen.name,
              (_) => false,
            );
          }
        });
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.red.shade100),
        iconColor: const WidgetStatePropertyAll(Colors.red),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Log out',
            style: TextStyle(color: Colors.red, fontSize: 16),
          ),
          SizedBox(width: 10.0),
          Icon(Icons.logout),
        ],
      ),
    );
  }
}
