import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csi_hackathon/constants.dart';
import 'package:csi_hackathon/resources/auth_methods.dart';
import 'package:csi_hackathon/screens/add_post_screen.dart';
import 'package:csi_hackathon/screens/home_screen.dart';
import 'package:csi_hackathon/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var userData = {};
  int _currentIndex = 0;
   
  final List<Widget> _tabs = [
    // HomeScreen(),
    // FavoritesScreen(),
    // ProfileScreen(),
    Home(),
    AddPostScreen(),
    Text('Gallery'),
  ];
  
  getData() async {
    try {
        var UserSnap =
        await FirebaseFirestore.instance.collection('users').doc(uidReturn()).get();
        setState(() {
          userData = UserSnap.data()!;
        });
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  String? uidReturn(){
  final FirebaseAuth _auth = FirebaseAuth.instance; 
  return _auth.currentUser!.uid;
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 130,
          automaticallyImplyLeading: false,
          backgroundColor: darkgreen,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset('assets/Chat_Screen_Logo.png'),
                  SizedBox(
                    width: 17,
                  ),
                  Text(
                    'Dermi',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Michroma",
                        fontSize: 25),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                ' Hello ,',
                style: TextStyle(color: Colors.white , fontFamily: "Manrope" , fontSize: 15),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                userData['username'] == null ? ' Pugazh' :' ${userData['username']} ' ,
                style: const TextStyle(color: Colors.white , fontFamily: "Manrope" , fontSize: 18),
              )
              
            ],
          ),
          bottom: const TabBar(
            indicatorColor: scaffoldBackgroundColor,
            indicatorPadding: EdgeInsets.only(bottom:5),
            tabs: [
              Tab(child: Text('Home',style: TextStyle(fontFamily: "Manrope",fontWeight:FontWeight.w400,fontSize: 15,color:scaffoldBackgroundColor),) ,),
              Tab(child: Text('Camera',style: TextStyle(fontFamily: "Manrope",fontWeight:FontWeight.w400,fontSize: 15,color:scaffoldBackgroundColor),) ),
              Tab(child: Text('Pick Image',style: TextStyle(fontFamily: "Manrope",fontWeight:FontWeight.w400,fontSize: 15,color:scaffoldBackgroundColor),) ),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
    );
  }
}
