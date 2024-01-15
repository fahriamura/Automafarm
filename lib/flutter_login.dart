import 'package:autofarm/mainpage/fitness_app/MainHomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'firebase_auth/firebase_auth_service.dart';


const users = {
  'a@gmail.com': '123',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Duration get loginTime => const Duration(milliseconds: 2250);


  Future<String?> _signupUser(LoginData data) async {

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: data.name, password: data.password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;

  }

  Future<String?> _authUser(LoginData data) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: data.name, password: data.password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }

    }
    return null;

  }



  Future<String?> _recoverPassword(String name) async {
    try {
      await _auth.sendPasswordResetEmail(email: name);
      return null;
    } catch (e) {
      return e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'AUTOMAFARM',
      logo: const AssetImage('assets/images/ayam.png'),

      onLogin: _authUser,
      onSignup: _signupUser,
      theme:LoginTheme(
        primaryColor: Colors.orangeAccent,
        accentColor: Colors.black,
      ),
      loginProviders: <LoginProvider>[
        LoginProvider(
          icon: FontAwesomeIcons.google,
          label: 'Google',
          callback: () async {
            debugPrint('start google sign in');
            await Future.delayed(loginTime);
            debugPrint('stop google sign in');
            return null;
          },
        ),
        LoginProvider(
          icon: FontAwesomeIcons.facebookF,
          label: 'Facebook',
          callback: () async {
            debugPrint('start facebook sign in');
            await Future.delayed(loginTime);
            debugPrint('stop facebook sign in');
            return null;
          },
        ),
      ],
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainHomeScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}