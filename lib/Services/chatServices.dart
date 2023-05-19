import 'package:chatapp/Services/helper.dart';
import 'package:chatapp/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatServices {
  // late UserModel userModel;
  FirebaseAuth _auth = FirebaseAuth.instance;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  Future createUser({required UserModel userModel}) async {
    try {
     await _auth
          .createUserWithEmailAndPassword(
              email: userModel.uEmail.toString(),
              password: userModel.uPassword.toString())
          .then((value)async {
             await userCollection.doc(getUserID()).set({userModel.toJson()});}



      );
    } catch (e) {
    }
  }
}
