import 'package:csi_hackathon/constants.dart';
import 'package:csi_hackathon/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:csi_hackathon/widgets/text_Field_widget.dart';
import 'package:csi_hackathon/resources/auth_methods.dart';
import 'package:csi_hackathon/screens/signUp_Screen.dart';
// import 'package:csi_hackathon/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  //Method to login the user
  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()));
    } else {
      //
      // showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Method for if not logged in then go to sign up screen
  void navigateToSignUp() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Hero(
                    tag: 'Hero',
                    child: Image.asset(
                      'assets/Sign_Signup_Page_Logo_color.png',
                      width: 155,
                      height: 155,
                    )),
                const SizedBox(
                  height: 15,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign in to ',
                      style: TextStyle(
                          fontSize: 22, fontFamily: "Manrope", color: Colors.black),
                    ),
                    Text(
                      'Dermi',
                      style: style,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 64,
                ),
                //text field input for email
                TextfieldInput(
                  hintText: 'Enter your Email',
                  isPass: false,
                  inputType: TextInputType.emailAddress,
                  textEditingController: _emailController,
                ),
                const SizedBox(
                  height: 24,
                ),
                //text field for password
                TextfieldInput(
                  hintText: 'Enter Your Password',
                  isPass: true,
                  inputType: TextInputType.text,
                  textEditingController: _passwordController,
                ),
                const SizedBox(
                  height: 24,
                ),
                //button Login
                TextButton(
                  onPressed: loginUser,
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                        color: darkgreen, borderRadius: BorderRadius.circular(20)),
                    child: _isLoading == true
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : const Center(
                            child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          )),
                  ),
                ),
                const SizedBox(height: 12),
            
                //Transitioning to signing up
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an Account ?"),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: navigateToSignUp,
                        child: const Text(
                          "Click here!",
                          style: TextStyle(
                              fontFamily: "Michroma",
                              color: darkgreen,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: bottom_text()),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
}
