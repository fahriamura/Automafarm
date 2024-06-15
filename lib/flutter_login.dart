import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:autofarm/mainpage/fitness_app/MainHomeScreen.dart';
import 'package:autofarm/mainpage/fitness_app/models/user.dart';
import 'package:autofarm/firebase_auth/firebase_auth_service.dart';

import 'mainpage/PoultryForm.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _signupUser(BuildContext context, SignupData data) async {
    try {
      Map<String, dynamic>? response = (await AuthApi.register(data.name, data.password)) as Map<String, dynamic>?;
      if (response != null && !response['error']) {
        // Navigate to FormView with UserID
        int userID = response['data']['user']['UserID'];
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => PoultryForm(userID: userID),
        ));
        return null; // Successfully signed up
      } else {
        return 'Failed to sign up: ${response?['message']}';
      }
    } catch (e) {
      return 'An error occurred: $e';
    }
  }

  Future<String?> _authUser(BuildContext context, LoginData data) async {
    try {
      UserData? userData = await AuthApi.login(data.name, data.password);
      print(userData);
      if (userData != null) {
        int userID = userData.userID;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MainHomeScreen(userID: userID),
        ));
        return null; // Successfully authenticated
      } else {
        return 'Invalid email or password.';
      }
    } catch (e) {
      print(e);
      return 'An error occurred: $e';

    }
  }

  Future<String?> _recoverPassword(String name) async {
    // Implement password recovery logic here
    return 'Password recovery not implemented.';
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      logo: const AssetImage('assets/images/LogoHackfest.png'),
      onLogin: (loginData) => _authUser(context, loginData),
      onSignup: (signupData) => _signupUser(context, signupData),
      theme: LoginTheme(
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
      onSubmitAnimationCompleted: () {},
      onRecoverPassword: _recoverPassword,
    );
  }
}
