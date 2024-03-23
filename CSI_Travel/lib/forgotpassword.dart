import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  TextEditingController _email = new TextEditingController();
  String email = '';
  bool showspinner = false;
  final _formkey = GlobalKey<FormState>();

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
        title: Text(
          'Forgot Password ',
          style: TextStyle(
              color: Colors.yellow[400],
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
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
                ElevatedButton(
                    onPressed: (() async {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          showspinner = true;
                        });
                      }
                      try {
                        _auth
                            .sendPasswordResetEmail(
                                email: _email.text.toString())
                            .then((value) {
                          setState(() {
                            showspinner = false;
                          });
                          toastMsg('Password reset link succesfully sent');
                        }).onError((error, stackTrace) {
                          toastMsg(error.toString());
                          setState(() {
                            showspinner = false;
                          });
                        });
                      } catch (e) {
                        setState(() {
                          showspinner = false;
                        });
                        toastMsg(e.toString());
                      }
                    }),
                    child: Text('Forgot')),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
