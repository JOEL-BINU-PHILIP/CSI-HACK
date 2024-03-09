import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  const Post({
    required this.postURL,
    required this.uid,
    required this.postId,
  });
  final String uid;
  final String postURL;
  final String postId;


  Map<String, dynamic> toJson() => {
        'uid': uid,
        'postId': postId,
        'postURL': postURL,
      };

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Post(
      uid: snapshot['uid'],
      postId: snapshot['postId'],
      postURL: snapshot['postURL'],
    );
  }
}
