import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram/resources/storage_methods.dart';
import 'package:instagram/models/user.dart' as model;

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> signUpUser({
    required String email,
    required String password,
    required String name,
    required String bio,
    required Uint8List file,
  }) async {
    String res = 'Signup Exception';
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          name.isNotEmpty ||
          bio.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        String photoUrl =
            await StorageMethods().uploadImageToStorage('profile', file, false);

        model.User user = model.User(
          name: name,
          uid: cred.user!.uid,
          email: email,
          bio: bio,
          followers: [],
          following: [],
          photoUrl: photoUrl,
        );
        //if use .add instead of .set - name & uid will be different, with set - match
        //await _firestore.collection('users').add({
        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    //todo why? is it a practice
    String res = 'Some error Occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = 'success';
      } else {
        res = 'Please enter all the fields';
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    return model.User.fromSnap(documentSnapshot);
  }
}
