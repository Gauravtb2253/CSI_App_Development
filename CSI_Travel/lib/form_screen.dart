import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Formscreen extends StatefulWidget {
  @override
  State<Formscreen> createState() => _FormscreenState();
}

class _FormscreenState extends State<Formscreen> {
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
    return ModalProgressHUD(
      inAsyncCall: showspinner,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal[300],
          title: Text('Registration form'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText(
                          'Welcome to Registration page',
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent[400],
                          ),
                        ),
                        TyperAnimatedText(
                          'This page is made by Omkar Lolage ',
                          textStyle: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.cyanAccent[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name should not be Blank";
                      }
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _email,
                    decoration: InputDecoration(
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
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: passController,
                    obscureText: toggle,
                    decoration: InputDecoration(
                        labelText: "Password",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
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
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    // controller: _phone,
                    decoration: InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: ((value) {
                      if (value!.isEmpty) {
                        return "Please enter mobile number";
                      }
                      bool phonevalid =
                          RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)').hasMatch(value);
                      if (!phonevalid) {
                        return "Invalid Mobile number";
                      }
                    }),
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
                            final user =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email.toString().trim(),
                                    password: password.toString().trim());
                            if (user != null) {
                              toastMsg('Successfully registered');
                              setState(() {
                                showspinner = false;
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Loginscreen()));
                            }
                          } catch (e) {
                            setState(() {
                              showspinner = false;
                            });
                            toastMsg(e.toString());
                          }
                        }
                      }),
                      child: Text('Register')),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ?",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      TextButton(
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Loginscreen()));
                          }),
                          child: Text(
                            "Log in",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
