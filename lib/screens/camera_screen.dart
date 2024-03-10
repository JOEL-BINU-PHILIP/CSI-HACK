import 'dart:typed_data';
import 'package:csi_hackathon/constants.dart';
import 'package:csi_hackathon/screens/result_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:csi_hackathon/resources/firestore_methods.dart';
import 'package:csi_hackathon/utils.dart';
// import 'package:instagram_clone/providers/user_provider.dart';
// import 'package:provider/provider.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  void navigateToResultScreen(String res) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultScreen(res: res,file:_file!),
      ),
    );
  }

//The _selectImage function is to return a DialogBox on which the user can chose to
//take the photo from gallery or camera or something else.
  bool _isLoading = false;
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
  void postImage(Uint8List Image) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadImage(_file as Uint8List);
      setState(() {
        _isLoading = false;
      });
      if (res == 'success') {
        clearImage();
      } else {
        navigateToResultScreen(res);
      }
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  _selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            backgroundColor: scaffoldBackgroundColor,
            elevation: 6,
            title: const Center(child: Text(' Take a Picture ')),
            children: [
              SimpleDialogOption(
                //Here we are padding because otherwise all the options wil get squeezed together
                padding: const EdgeInsets.only(right: 40 , left: 40 , top: 5 , bottom: 5),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
                child:  Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black, // Change the color as per your preference
                    width: 2.0, // Adjust the width of the border
                  )),
                  child: const Center(
                    child: Text('Take a photo' , style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              // SimpleDialogOption(
              //   //Here we are padding because otherwise all the options wil get squeezed together
              //   padding: const EdgeInsets.all(20),
              //   onPressed: () async {
              //     Navigator.of(context).pop();
              //     Uint8List? file = await pickImage(ImageSource.gallery);
              //     setState(() {
              //       _file = file;
              //     });
              //   },
              //   child: const Text('Choose from gallery'),
              // ),
              SimpleDialogOption(
                //Here we are padding because otherwise all the options wil get squeezed together
                padding: const EdgeInsets.only(right: 40 , left: 40 , top: 5 , bottom: 5),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.black, // Change the color as per your preference
                    width: 2.0, // Adjust the width of the border
                  )),
                  child: const Center(
                    child: Text('Cancel' , style: TextStyle(color: Colors.white),),
                  ),
                ),
              )
            ],
          );
        });
  }

  void clearImage() {
    setState(() {
      _file = null;
    });
  }

  String uidReturn() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? GestureDetector(
            onTap: () => _selectImage(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('assets/camera.png'),

                  // child: IconButton(
                  //     icon: const Icon(Icons.upload),
                  //     onPressed: () => _selectImage(context)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Open Camera',
                  style: TextStyle(
                      fontSize: 22,
                      fontFamily: "Manrope",
                      color: Colors.black,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          )
        : Scaffold(
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator(
                        color: midgreen,
                      )
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                SizedBox(
                  height: 20,
                ),
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
                            image: MemoryImage(_file!),
                            fit: BoxFit.fill,
                            alignment: FractionalOffset.topCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    postImage(_file!);
                  },
                  child: const Text(
                    'Diagnose',
                    style: TextStyle(
                      color: darkgreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: clearImage,
                  child: const Text(
                    'Clear',
                    style: TextStyle(
                      color: darkgreen,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
