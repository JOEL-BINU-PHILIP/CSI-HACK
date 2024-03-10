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

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

//The _selectImage function is to return a DialogBox on which the user can chose to
//take the photo from gallery or camera or something else.
  bool _isLoading = false;
  Uint8List? _file;
  final TextEditingController _descriptionController = TextEditingController();
    void navigateToResultScreen(String res) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>ResultScreen(res: res,file:_file!),
      ),
    );
  }
  void postImage(Uint8List image, String uid) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadImage(_file!);
      setState(() {
        _isLoading = false;
      });
      if (res == 'success') {
        showSnackBar('Posted!', context);
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
            title: const Center(child: Text(' Choose a Picture ')),
            children: [
              SimpleDialogOption(
                //Here we are padding because otherwise all the options wil get squeezed together
               padding: const EdgeInsets.only(right: 40 , left: 40 , top: 5 , bottom: 5),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
                //Here we are padding because otherwise all the options wil get squeezed together
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
                    child: Text('Choose a photo' , style: TextStyle(color: Colors.white)),
                  ),
                ),
                
              ),
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
              // SimpleDialogOption(
              //   //Here we are padding because otherwise all the options wil get squeezed together
              //   padding: const EdgeInsets.all(20),
              //   onPressed: () {
              //     Navigator.of(context).pop();
              //   },
              //   child: const Text('Cancel'),
              // )
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
                  child: Image.asset('assets/gallery.png'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Open Gallery',
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
                    ? const LinearProgressIndicator()
                    : const Padding(padding: EdgeInsets.only(top: 0)),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 375,
                    width: 375,
                    child: AspectRatio(
                      aspectRatio: 487 / 451,
                      child: Container(
                        decoration: BoxDecoration(
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
                onPressed:() => postImage(_file! , uidReturn()),
                child: const Text(
                  'Diagnose',
                  style: TextStyle(
                    color: darkgreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(onPressed: clearImage,  child: const Text(
                  'Clear',
                  style: TextStyle(
                    color: darkgreen,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),)
              ],
            ),
          );
  }
}

