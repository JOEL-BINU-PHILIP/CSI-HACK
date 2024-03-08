import 'package:csi_hackathon/screens/login_screen.dart';
import 'package:csi_hackathon/screens/signUp_Screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  //Method to navigate to The LoginScreen
  void navigateToLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

    return SafeArea(
      child: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    AccessButton(buttonText: 'Login', onPressed: navigateToSignUp),
                    AccessButton(buttonText: 'Register', onPressed: navigateToLoginScreen)
                ],
              ),
    ));
  }
}


class AccessButton extends StatelessWidget {
  const AccessButton(
      {super.key, required this.buttonText, required this.onPressed});
  final Function() onPressed;
  final String buttonText;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(4)),
        child: Center(child: Text(buttonText)),
      ),
    );
  }
}