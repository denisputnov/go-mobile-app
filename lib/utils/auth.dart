import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'variables/userdata.dart' as userdata;

import 'package:shared_preferences/shared_preferences.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

Future<User> signInWithGoogle() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication = 
    await googleSignInAccount.authentication;

  final AuthCredential credential = GoogleAuthProvider.credential(
    idToken: googleSignInAuthentication.idToken, 
    accessToken: googleSignInAuthentication.accessToken);

  final UserCredential authResult = await _auth.signInWithCredential(credential);
  final User user = authResult.user;

  assert(!user.isAnonymous);
  assert(await user.getIdToken() != null);

  final User currentUser = _auth.currentUser;
  assert(currentUser.uid == user.uid);

  await prefs.setString('uid', user.uid);
  await prefs.setString('displayName', user.displayName);
  await prefs.setString('photoURL', user.photoURL);
  await prefs.setString('email', user.email);
  await prefs.setBool('isAuthorized', true);
  
  userdata.uid = user.uid;
  userdata.username = user.displayName;
  userdata.userPhoto = Image.network(user.photoURL);
  userdata.email = user.email;
  userdata.isAuthorized = true;

  return user;
}

void singOutWithGoogle() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  await prefs.remove('uid');
  await prefs.remove('displayName');
  await prefs.remove('photoURL');
  await prefs.remove('email');
  await prefs.remove('isAuthorized');

  userdata.isAuthorized = false;
  userdata.userPhoto = Image.asset('./assets/icons/avatar-placeholder.jpg');
  userdata.username = "...";
  userdata.email = "...";
  userdata.uid = '';

  await googleSignIn.signOut();
}