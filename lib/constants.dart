import 'package:flutter/material.dart';

const Color scaffoldBackgroundColor = Colors.white;
const Color darkgreen = Color(0xFF199388);
const Color appbar_text_color = Color.fromARGB(255, 28, 168, 156);
const Color midgreen = Color(0xFF73E2D8);
const TextStyle style = TextStyle(
    fontSize: 25,
    fontFamily: "Michroma",
    fontWeight: FontWeight.bold,
    color: darkgreen);
const Widget Team = Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text(
      'Developed by ',
      style: TextStyle(color: Colors.grey),
    ),
    Text(
      'QuadrX',
      style: TextStyle(color: darkgreen),
    ),
  ],
);

const subtitle = TextStyle(fontFamily: 'Michroma',fontWeight: FontWeight.w400,fontSize: 17);




//bottom [by team Quadrx]
class bottom_text extends StatelessWidget {
  const bottom_text({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:15,bottom:15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("by Team ",style:TextStyle(fontWeight: FontWeight.w200,fontFamily: "Michroma",fontSize: 10)),
          Text("QuadrX",style:TextStyle(fontWeight: FontWeight.w600,fontFamily: "Michroma",fontSize: 13,color: darkgreen,))
        ],
      ),
    );
  }
}