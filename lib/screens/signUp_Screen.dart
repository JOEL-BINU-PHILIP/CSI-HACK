import 'package:csi_hackathon/constants.dart';
import 'package:csi_hackathon/screens/main_screen.dart';
import 'package:flutter/material.dart';
// import 'dart:typed_data';
import 'package:csi_hackathon/widgets/text_Field_widget.dart';
import 'package:csi_hackathon/resources/auth_methods.dart';
import 'package:csi_hackathon/screens/login_screen.dart';
import 'package:csi_hackathon/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  // Uint8List? _image;
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    // _bioController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

// // To select the image from gallery
//   void selectImage() async {
//     try {
//       Uint8List im = await pickImage(ImageSource.gallery);
//       setState(() {
//         _image = im;
//       });
//     } catch (e) {
//       print('You have not selected Image');
//     }
//   }

//Method to SignUp the user
  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
   
    String res = await AuthMethods().signUpUser(
      email: _emailController.text,
      password: _passwordController.text,
      username: _usernameController.text,
      // bio: _bioController.text,
      // file: _image!,
    );
    
    setState(() {
      _isLoading = false;
    });
    if (res != "success") {
      showSnackBar(res, context);
            Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()));
    } else {
      print(res);
      navigateToLoginScreen();
    }
  }

//Method to navigate to The LoginScreen
  void navigateToLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Hero(tag: 'Hero',child: Image.asset('assets/Sign_Signup_Page_Logo_color.png' , width: 155 , height: 155,)),
              SizedBox(height: 15,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Sign in to ', style: TextStyle(fontSize: 22 , fontFamily: "Manrope" , color: Colors.black),),
                  Text('Dermi' , style: style,),
                ],
              ),
                const SizedBox(
                  height: 44,
                ),
                //text field input for Username
                TextfieldInput(
                  hintText: 'Enter your Username',
                  isPass: false,
                  inputType: TextInputType.text,
                  textEditingController: _usernameController,
                ),
                const SizedBox(
                  height: 24,
                ),
                //text field input for Bio
                // TextfieldInput(
                //   hintText: 'Enter your bio',
                //   isPass: false,
                //   inputType: TextInputType.text,
                //   textEditingController: _bioController,
                // ),
                // const SizedBox(
                //   height: 24,
                // ),
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
                //button signup
              TextButton(
                onPressed: signUpUser,
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                      color: darkgreen, borderRadius: BorderRadius.circular(20)),
                  child: _isLoading == true
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: scaffoldBackgroundColor,
                          ),
                        )
                      : const Center(
                          child: Text(
                          'Sign Up Now',
                          style: TextStyle(color: Colors.white),
                        )),
                ),
              ),
                const SizedBox(height: 12),
          
                //Transitioning to logging up
                Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an Account ?"),
                    SizedBox(width: 10,),
                    GestureDetector(
                      onTap: navigateToLoginScreen,
                      child: Container(
                        child: const Text(
                          "Click here!",
                          style: TextStyle(
                            fontFamily: "Michroma",
                              color: darkgreen, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            SizedBox(height: 44,),
            bottom_text()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
