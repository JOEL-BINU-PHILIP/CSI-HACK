import 'dart:convert';
import 'package:csi_hackathon/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:speech_to_text/speech_to_text.dart' as stt;

class DermiChat extends StatefulWidget {
  final String report;
  DermiChat({required this.report});
  @override
  _DermiChatState createState() => _DermiChatState();
}

class _DermiChatState extends State<DermiChat> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _chatMessages = [];
  bool isLoading = false;
  final ScrollController _scrollController =
      ScrollController(); // Add this line

  stt.SpeechToText _speechToText = stt.SpeechToText();
  String _recognizedText = '';

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    // try{
    // _initializeSpeechToText();}
    // catch(e){
    //     print(e.toString());
    // }
  }

  // void _initializeSpeechToText() async {
  //   bool isAvailable = await _speechToText.initialize(
  //     onStatus: (status) {
  //       print('Speech status: $status');
  //     },
  //     onError: (error) {
  //       print('Speech error: $error');
  //     },
  //   );

  //   if (isAvailable) {
  //     print('Speech recognition initialized successfully');
  //   } else {
  //     print('Error initializing speech recognition');
  //   }
  // }

  // void _startListening() async {
  //   if (_speechToText.isAvailable && !_speechToText.isListening) {
  //     bool isStarted = await _speechToText.listen(
  //       onResult: (result) {
  //         setState(() {
  //           print(result.recognizedWords);
  //           _recognizedText = result.recognizedWords;
  //         });
  //       },
  //     );

  //     if (isStarted) {
  //       print('Speech recognition started');
  //     } else {
  //       print('Error starting speech recognition');
  //     }
  //   }
  // }

  // void _stopListening() async {
  //   if (_speechToText.isListening) {
  //     _speechToText.stop();
  //     print('Speech recognition stopped');
  //   }
  // }

  Future<String> chatWithDermi(String question) async {
    String res = 'some Error occurred';
    try {
      print(question);
      var response = await http.post(
        Uri.parse('https://chatbot-sp6egsqylq-el.a.run.app/chatbot'),
        body: jsonEncode({'text': question}),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      print("========================================${response.body}");
      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        // Access the value of the "response" key
        String botResponse = jsonResponse['response'];
        // Print or return the bot response
        print("Bot response: $botResponse");
        return botResponse;
      } else {
        print("Error: ${response.statusCode}");
        return res;
      }
    } catch (e) {
      print("Exception occurred: $e");
      return res;
    }
  }

  // Function to handle sending a message
  void _sendMessage(String message) async {
    // Scroll to the bottom of the ListView
    void _scrollToBottom() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      });
    }

    setState(() {
      isLoading = true;
    });
    print("===========${message}");
    String aiResponse;
    // Add the user's message to the chat
    //_chatMessages.add({"sender": "user", "message": message});
    // Call the AI model with the user's message and add AI's response to the chat
    // Replace this with your logic to interact with your AI model
    if (message.isEmpty) {
      aiResponse = "Oops! Type something so that i can answer";
    } else {
      aiResponse = await chatWithDermi(message);
    }
    // Placeholder for AI response
    _chatMessages.add({"sender": "ai", "message": aiResponse});
    // Clear the text field
    _controller.clear();
    _scrollToBottom();
    // Update the UI
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer:Drawer(
  width: 300, // Set the desired width for the drawer
  
  // Set background color with transparency
  backgroundColor: Color.fromARGB(133, 53, 53, 53),
  
  child: Container(
    // width: 300, // Remove width from Container
    
    child: SingleChildScrollView(
      child: Column( // Replace ListView with Column
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(191, 17, 17, 17),
            ),
            child: Container(
              width: double.infinity,
              child: Text(
                "REPORT",
                style: TextStyle(
                  fontFamily: "Michroma",
                  fontWeight: FontWeight.w500,
                  color: midgreen,
                  fontSize: 25,
                ),
              ),
            ),
          ),
         
          Container(
            child: ListTile(
              title: SelectableText(
                widget.report,
                style: TextStyle(fontFamily: "Manrope", color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),




      appBar: AppBar(
        actions: [
          IconButton(onPressed: (){
            _scaffoldKey.currentState?.openDrawer();
          }, icon: Icon(Icons.article_rounded,color:Colors.white))
        ],
        backgroundColor: darkgreen,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color:Colors.white)),
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('assets/Chat_Bot_App_Bar.png'),
            SizedBox(width: 10),
            Text(
              "Dermi Chat",
              style: TextStyle(
                  fontFamily: "Michroma",
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xFFE5FBF9),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: darkgreen, width: 2)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            Image.asset('assets/Chat_Bot_Logo.png', height: 40),
                      ),
                      Row(
                        children: [
                          Text(
                            "Here is your ",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: "Manrope",
                                fontSize: 15),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Dermi AI",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: "Michroma",
                                fontSize: 15,
                                color: darkgreen),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                return ListTile(
                  title: Align(
                    alignment: message["sender"] == "user"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: message_box(message: message),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    cursorColor: darkgreen,
                    controller: _controller,
                    decoration: InputDecoration(
                      filled: true, // Set to true to enable background color
                      fillColor: Color(0xFFE5FBF9),
                      hintText: "Chat here...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: darkgreen),
                        borderRadius: BorderRadius.circular(30),
                      ),

                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: darkgreen, width: 2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: darkgreen,
                            width: 2), // Border color when focused
                        borderRadius: BorderRadius.circular(30),
                      ),

                      suffixIcon: IconButton(
                        icon: isLoading == true
                            ? /* CircularProgressIndicator(
                            valueColor: Colors.green,
                            color:darkgreen,
                            
                          )*/
                            CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    darkgreen), // valueColor parameter
                                backgroundColor: Colors
                                    .transparent, // backgroundColor parameter
                                value:
                                    null, // value parameter (null means indeterminate)
                                strokeWidth: 4.0, // strokeWidth parameter
                                semanticsLabel:
                                    'Loading', // semanticsLabel parameter
                                semanticsValue:
                                    'Loading', // semanticsValue parameter
                              )
                            : Icon(Icons.send, color: darkgreen),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          _chatMessages.add(
                              {"sender": "user", "message": _controller.text});
                          _sendMessage(_controller.text);
                          _controller.clear();

                          // Handle send button press
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                /*ElevatedButton(
                  onPressed: () {
                        FocusScope.of(context).unfocus();
                      _sendMessage(_controller.text);
                    
                  },
                  child: Text("Send"),
                ),*/
                GestureDetector(
                  //  onLongPress: _startListening,
                  // onLongPressEnd: (details) => _stopListening(),

                  child: CircleAvatar(
                    radius: 26,
                    backgroundColor: darkgreen,
                    child: GestureDetector(
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.mic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class message_box extends StatelessWidget {
  message_box({
    super.key,
    required this.message,
  });
  FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-IN');
    await flutterTts
        .setVoice({"name": "en-us-x-sfg#male_2-local"}); // Set male voice
    await flutterTts.setSpeechRate(0.1); // Adjust speech rate for slower speech
    await flutterTts.setPitch(1); // Set the pitch to default (1.0)
    await flutterTts.speak(text);
  }

  final Map<String, String> message;

  @override
  Widget build(BuildContext context) {
    var Ai_text_color = Colors.white;
    var Ai_text_box_color = Colors.black;
    return Padding(
      padding: EdgeInsets.only(
        right: message["sender"] == "user" ? 0 : 50,
        left: message["sender"] == "user" ? 50 : 0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (message["sender"] != "user")
            Row(
              children: [
                Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: Ai_text_box_color)),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset('assets/Chat_Screen_Logo_color.png',
                          height: 15),
                    )),
                IconButton(
                    onPressed: () {
                      flutterTts.speak(message['message']!);
                    },
                    icon: Icon(Icons.speaker_group_sharp)),
              ],
            ),
          SizedBox(height: 3),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color:
                  message["sender"] == "user" ? darkgreen : Ai_text_box_color,
              borderRadius: BorderRadius.only(
                topLeft: message["sender"] == "user"
                    ? Radius.circular(15)
                    : Radius.circular(0),
                topRight: message["sender"] == "user"
                    ? Radius.circular(0)
                    : Radius.circular(15),
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Text(
              message["message"]!,
              style: TextStyle(
                  color: message["sender"] == "user"
                      ? Colors.white
                      : Ai_text_color),
            ),
          ),
        ],
      ),
    );
  }
}
