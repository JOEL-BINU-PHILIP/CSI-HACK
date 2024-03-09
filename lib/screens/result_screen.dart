import 'package:csi_hackathon/constants.dart';
import 'package:csi_hackathon/screens/Dermi_chat.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({super.key, required this.res});
  final String res;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  //   void navigateToChatScreen() {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => DermiChat(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('Your Result :-' , style: style, ),
                Center(
               child: Text(widget.res),
               
            ),
            TextButton(onPressed: () {}, child: Text('Chat'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
          // child: Center(
          //   child: Text(widget.res),
          // ),