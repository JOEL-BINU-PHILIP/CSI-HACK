import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  const User(
      {
      required this.uid,
      required this.email,
      required this.username
      });
  final String uid;
  final String username;
  final String email;

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      uid: snapshot['uid'],
      email: snapshot['email'],
      username: snapshot['username'],
    );
  }
}