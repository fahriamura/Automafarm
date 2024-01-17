import 'package:autofarm/firebase_auth/firebase_auth_service.dart';
import 'package:autofarm/mainpage/fitness_app/MainHomeScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'mainpage/PoultryForm.dart';


class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  final _get = FirebaseFirestore.instance;
  createUser(UserModel user) async {
    await _get.collection("Users").add(user.toJson()).whenComplete(
        () => Get.snackbar("Succes", "Your Poultry has been Created.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green),
    )
    .catchError((error, stackTrace){
      Get.snackbar("Error", "Something Went Wrong. Try Again",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withOpacity(0.1),
      colorText: Colors.red);
      print(error.toString());
    });
  }
}

class LoginScreen extends StatelessWidget{
  LoginScreen({super.key});
  final LoginController loginController = Get.put(LoginController());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Duration get loginTime => const Duration(milliseconds: 2250);

  get onSignup => null;

  Future<String?> _signupUser(SignupData data) async {

    try {
      await _auth.createUserWithEmailAndPassword(email: data.name, password: data.password);
      var user = FirebaseAuth.instance.currentUser;
      Navigator.of(Get.context!).pushReplacement(MaterialPageRoute(
        builder: (context) => PoultryForm(user: user),
      ));
      return null; // Successfully signed up
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'The email address is already in use.';
      } else {
        return 'An error occurred: ${e.code}';
      }
    }
  }

  Future<String?> _authUser(LoginData data) async {
    try {
      await _auth.signInWithEmailAndPassword(email: data.name, password: data.password);
      return null; // Successfully authenticated
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return 'Invalid email or password.';
      } else {
        return 'An error occurred: ${e.code}';
      }
    }
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
      logo: const AssetImage('assets/images/LogoHackfest.png'),

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
        if (onSignup != null) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MainHomeScreen(),
          ));
        }
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}