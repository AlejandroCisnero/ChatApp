import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:path_provider/path_provider.dart';
import '../firebase_options.dart';
import './authentication.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  Future<void> init() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
        _userCredential = user;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
        _userCredential = null;
      }
      notifyListeners();
    });
  }

  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  ApplicationLoginState get loginState => _loginState;

  String? _email;
  String? get email => _email;
  File? _userProfileImage;
  String? _userImageUrl;

  User? _userCredential;
  User? get user => _userCredential;
  String? get userImageUrl => _userImageUrl;

  void startLoginFlow() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      final userAuthData =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_images')
          .child('${userAuthData.user!.uid}.jpg');
      _userImageUrl = await ref.getDownloadURL();
      log(_userImageUrl!);
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

  Future<void> registerAccount(
      String email,
      String displayName,
      String password,
      String username,
      void Function(FirebaseAuthException e) errorCallback) async {
    try {
      if (_userProfileImage != null) {
        var credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        //Image upload
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${credential.user!.uid}.jpg');

        await ref.putFile(_userProfileImage!);

        final userImageUrl = await ref.getDownloadURL();
        //------------
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user!.uid)
            .set({
          'username': username,
          'email': email,
          'userId': FirebaseAuth.instance.currentUser!.uid,
          'userImageUrl': userImageUrl
        });
        await credential.user!.updateDisplayName(displayName);
      } else {
        throw Exception("No user profile found");
      }
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  void signOut() {
    _userProfileImage = null;
    FirebaseAuth.instance.signOut();
  }

  void setUserImage(File userImage) {
    _userProfileImage = userImage;
  }
}
