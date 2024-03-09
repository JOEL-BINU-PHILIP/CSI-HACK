import 'package:csi_hackathon/constants.dart';
import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView
      (
        physics: AlwaysScrollableScrollPhysics(),
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height:20),
            Text("Welcome to Dermi",style: subtitle,),
            SizedBox(height:15),
            Image.asset('assets/Intro_Box.png'),

            SizedBox(height:20),
            Text("Features of Dermi",style: subtitle,),
            Divider(
              color: darkgreen,
            ),
            

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/feature 1.png',fit: BoxFit.contain,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/feature 2.png',fit:BoxFit.contain),
            ),

            bottom_text(),

    


        
          ],
        ),
      )),
    );
  }
}