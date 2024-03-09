import 'package:csi_hackathon/constants.dart';
import 'package:csi_hackathon/screens/login_screen.dart';
import 'package:csi_hackathon/screens/signUp_Screen.dart';
import 'package:flutter/material.dart';

class StartingPage extends StatelessWidget {
  const StartingPage({super.key});

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
      body: Stack(children: [
        Image.asset(
            'assets/bg_image_auth.png', 
            width: 400,
          ),
 Positioned(
              top: MediaQuery.of(context).size.height / 2 - 375, // Adjust to center vertically
              left: MediaQuery.of(context).size.width / 2 - 100, // Adjust to center horizontally
              child: Hero(
                tag: 'Hero',
                createRectTween: (begin, end) {
                  return RectTween(begin: begin, end: end);
                },
                child: Image.asset(
                  'assets/Sign_Signup_Page_Logo.png',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Dermi' , style: TextStyle(fontSize: 40,color: Colors.white, fontFamily: "Michroma"),),
            SizedBox(height:250),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sign in to ', style: TextStyle(fontSize: 22)),
                Text('Dermi' ,style: TextStyle(fontSize: 25 , fontFamily: "Michroma" , fontWeight: FontWeight.bold , color: darkgreen),)
              ],
            ),
            AccessButton(buttonText: 'Login', onPressed: navigateToLoginScreen),
            AccessButton(buttonText: 'Register', onPressed: navigateToSignUp),
             bottom_text(),
            SizedBox(
              height: 18,
            )
          ],
        ),
      ]),
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
        width: 300,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            border: Border.all(
              // Add border here
              color: Colors.black, // Set border color
              width: 2.0, // Set border width
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text(buttonText , style: TextStyle(color: darkgreen ),)),
      ),
    );
  }
}
