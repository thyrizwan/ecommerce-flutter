import 'package:ecommerce/features/auth/ui/screens/sign_in_screen.dart';
import 'package:flutter/material.dart';

class LogInWidget extends StatefulWidget {
  const LogInWidget({
    super.key,
  });

  @override
  State<LogInWidget> createState() => _LogInWidgetState();
}

class _LogInWidgetState extends State<LogInWidget> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, SignInScreen.name);
        setState(() {});
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(Colors.blue.shade100),
        iconColor: const WidgetStatePropertyAll(Colors.blue),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Log in',
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
          SizedBox(width: 10.0),
          Icon(Icons.login),
        ],
      ),
    );
  }
}
