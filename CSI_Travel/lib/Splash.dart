import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/homepage.dart';
import 'package:flutter_chatgpt/login.dart';

import 'form_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    final user = auth.currentUser;
    if (user != null) {
      _navigatetohome();
    } else {
      _navigatetologin();
    }
  }

  _navigatetohome() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  _navigatetologin() async {
    await Future.delayed(Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Loginscreen()));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Image(
        image: NetworkImage('./assets/images/logo.jpg'),
        width: MediaQuery.of(context).size.width * .5,
        height: MediaQuery.of(context).size.height * .5,
      ),
      backgroundColor: Colors.black,
      nextScreen: Formscreen(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
