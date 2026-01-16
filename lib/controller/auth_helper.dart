import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/controller/database_helper.dart';
import 'package:todo/controller/firestore_helper.dart';
import 'package:todo/view/auth/login_screen.dart';

class AuthHelper {

  Future<String> signUp(String email, String password, BuildContext context) async{
    try{
      final userCred = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      await FirestoreHelper().createUser(userCred.user!);
      
      return "success";
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
    catch(e){
      // return "Failure";
      return e.toString();
    }
  }

  Future<String> login(String email, String password, BuildContext context) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);

      // Force the database to initialize/open before fetching
      await DatabaseHelper().db;

      await FirestoreHelper().fetchTaskFire();

      return "success";
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    }
    catch(e){
      // return "Failure";
      return e.toString();
    }
  }

  logout(BuildContext context) async {
  // Call the reset method we discussed to clear the connection
  await DatabaseHelper().resetDatabase(); 
  await FirebaseAuth.instance.signOut();
  
  if (context.mounted) {
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context) => const LoginScreen())
    );
  }
}

}