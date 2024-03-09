import 'dart:typed_data';
import 'package:csi_hackathon/constants.dart';
import 'package:csi_hackathon/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:csi_hackathon/resources/firestore_methods.dart';
import 'package:csi_hackathon/utils.dart';
// import 'package:instagram_clone/providers/user_provider.dart';
// import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
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
  void postImage(Uint8List image, String uid) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await FireStoreMethods().uploadPost(_file!, uid);
      setState(() {
        _isLoading = false;
      });
      if (res == 'success') {
        showSnackBar('Posted!', context);
        clearImage();
      } else {
        showSnackBar(res, context);
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
            title: const Center(child: Text(' Take a Picture ')),
            children: [
              SimpleDialogOption(
                //Here we are padding because otherwise all the options wil get squeezed together
                padding: const EdgeInsets.all(20),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List? file = await pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
                child: const Text('Take a photo'),
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
                padding: const EdgeInsets.all(20),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              )
            ],
          );
        });
  }

  void clearImage() {
    Navigator.of(context).pop();
    _file = null;
  }

  String uidReturn() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return _auth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    return _file == null
        ? Center(
            child: IconButton(
                icon: const Icon(Icons.upload),
                onPressed: () => _selectImage(context)),
          )
        : Scaffold(
            // actions: [
            //   TextButton(
            //     onPressed:() => postImage(_file! , uidReturn()),
            //     child: const Text(
            //       'Post',
            //       style: TextStyle(
            //         color: Colors.blueAccent,
            //         fontWeight: FontWeight.bold,
            //         fontSize: 16,
            //       ),
            //     ),
            //   )
            // ],

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
                style: ButtonStyle(
              
                ),
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
