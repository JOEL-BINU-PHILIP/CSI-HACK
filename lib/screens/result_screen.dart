import 'dart:typed_data';

import 'package:csi_hackathon/constants.dart';
import 'package:csi_hackathon/screens/Dermi_chat.dart';
import 'package:csi_hackathon/screens/home_screen.dart';
import 'package:csi_hackathon/screens/main_screen.dart';
import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({super.key, required this.res,required this.file});
  final String res;
  final Uint8List file;
  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Your Report ',
                  style: style,
                ),
                const Divider( thickness: 2, color: darkgreen,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 375,
                    width: 375,
                    child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            style: BorderStyle.solid,
                            color:
                                darkgreen, // Change the color as per your preference
                            width: 4.0, // Adjust the width of the border
                          ),
                          image: DecorationImage(
                            image: MemoryImage(widget.file),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SelectableText(widget.res),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration:  BoxDecoration(
                        color: darkgreen,
                        borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                        style: BorderStyle.solid,
                        color: Colors.black, // Change the color as per your preference
                        width: 2.0, // Adjust the width of the border
                      ),),
                      
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: TextButton(                   
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => DermiChat(report:widget.res),
                                ),
                              );
                            },
                            child: const Text('Chat with Dermi AI', style: TextStyle( color: scaffoldBackgroundColor),)),
                      ),
                    ),


                    SizedBox(width:10),

                    Container(
                  decoration:  BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black, // Change the color as per your preference
                    width: 2.0, // Adjust the width of the border
                  ),),
                  
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(                   
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
                        },
                        child: const Text('Exit', style: TextStyle( color: scaffoldBackgroundColor),)),
                  ),
                )
                  ],
                ),


                bottom_text(),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
