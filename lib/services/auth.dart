import 'package:farm_to_me/services/databaseManager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/users.dart';
import 'package:flutter/material.dart';














class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;




  //create a user obj based on FirebaseUser
  UserOb? _userFromFirebaseUser(User? user){

    return user!=null ?UserOb(uid: user.uid):null;
  }



  UserObj? _userRegistrationFromFirebaseUser(User? user){

    return user!=null ?UserObj(uid: user.uid,email: user.email!, ):null;
  }

  //auth change user stream- ensures we get some info when user signs in or out
  Stream<UserObj?> get user {
    // if (!flag) {
    return _auth.authStateChanges()
    //.map((User? user)=> _userFromFirebaseUser(user));
        .map((User? user) => _userRegistrationFromFirebaseUser(user));
    // }
    // else {
    //return _auth.signOut();
    // }
  }

  Stream<UserOb?> get usermob {
    // if (!flag) {
    return _auth.authStateChanges()
    //.map((User? user)=> _userFromFirebaseUser(user));
        .map((User? user) => _userFromFirebaseUser(user));
    // }
    // else {
    //return _auth.signOut();
    // }
  }

  Future<String?> getCurrentUser() async{
    try{
      return await _auth.currentUser!.email;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in email and password
  Future signInWithEmailAndPassword(String email,String password) async {
    try {
      _auth.userChanges();
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return _userRegistrationFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInMobile(String phoneNumber) async {
    try {
      User? user;
      _auth.userChanges();
      await _auth.verifyPhoneNumber(
        phoneNumber: '+919744573172',
        codeSent: (String verificationId, int? resendToken) async {
          // Update the UI - wait for the user to enter the SMS code
          String smsCode = '123456';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          UserCredential result = await _auth.signInWithCredential(credential);
          user = result.user;

        }, verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  },
        verificationFailed: (FirebaseAuthException e) {},
        // codeSent: (String verificationId, int? resendToken) {},
        codeAutoRetrievalTimeout: (String verificationId) {},

      );

      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print("error while sign in with mobile $e");
    }
  }






  Future registerWithEmailandPasswordowner(String username,String password,String email,String phno,String role ) async{

    try{
      await UserLoginDataSaving().registerDataToFirebase(username,email,phno,role);
      UserCredential authResult=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user=authResult.user;
      print(authResult.credential);

      return _userRegistrationFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }

  }


  Future? deleteUser(){
    try{
      return _auth.currentUser!.delete();
    }
    catch(e){
      print(e);
      return null;
    }
  }

  //sign out
  Future userSignOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }






}