import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/form_screen.dart';
import 'package:flutter_chatgpt/homepage.dart';
import 'package:flutter_chatgpt/pages/input.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  TextEditingController _email = new TextEditingController();
  TextEditingController passController = TextEditingController();
  String email = '', password = '';
  bool showspinner = false;
  final _formkey = GlobalKey<FormState>();
  bool toggle = true;

  FirebaseAuth _auth = FirebaseAuth.instance;

  void toastMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Login ',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal[300],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'Welcome !!!',
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent[400],
                        ),
                      ),
                      TyperAnimatedText(
                        'Please Login',
                        textStyle: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.cyanAccent[400],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: _email,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return "Please enter email";
                    }
                    bool emailvalid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailvalid) {
                      return "Invalid email";
                    }
                  }),
                  onChanged: (value) {
                    email = value;
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: passController,
                  obscureText: toggle,
                  decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock_outline_rounded),
                      suffix: InkWell(
                        onTap: () {
                          setState(() {
                            toggle = !toggle;
                          });
                        },
                        child: Icon(
                            toggle ? Icons.visibility : Icons.visibility_off),
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Password";
                    } else if (passController.text.length <= 5) {
                      return "Password length should be more than five  ";
                    }
                  },
                  onChanged: (value) {
                    password = value;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Formscreen()));
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text('Forgot Password'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: (() async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          showspinner = true;
                        });
                        try {
                          final user = await _auth.signInWithEmailAndPassword(
                              email: email.toString().trim(),
                              password: password.toString().trim());
                          if (user != null) {
                            toastMsg('Login Successful');
                            setState(() {
                              showspinner = false;
                            });
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => HomePage()));
                          }
                        } catch (e) {
                          setState(() {
                            showspinner = false;
                          });
                          toastMsg(e.toString());
                        }
                      }
                    }),
                    child: Text('Login')),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account ?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                        onPressed: (() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Formscreen()));
                        }),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlueAccent,
                              letterSpacing: 2),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
