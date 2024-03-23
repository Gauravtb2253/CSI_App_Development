import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chatgpt/login.dart';
import 'package:flutter_chatgpt/pages/input.dart';
import 'package:flutter_chatgpt/utilities/colors.dart';
import 'widgets/category_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  String? email = FirebaseAuth.instance.currentUser?.email;
  String? name = FirebaseAuth.instance.currentUser?.displayName;
  @override
  Widget build(BuildContext context) {
    onWillPop:
    () async {
      SystemNavigator.pop();
      return true;
    };
    return Scaffold(
      backgroundColor: kWhiteClr,
      appBar: AppBar(
        title: Text(
          "CSI Travel Saarthi",
          style: GoogleFonts.dancingScript(
              textStyle:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loginscreen()));
                });
              },
              child: Icon(Icons.logout_outlined),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.indigo,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage('./assets/images/logo.jpg')),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "Welcome, $name",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "$email",
                    style: TextStyle(color: kWhiteClr),
                  ),
                ],
              ),
            ),
            ListTile(
              title: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.home,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "  Home",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.settings,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "  Settings",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              title: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(
                        Icons.stars_outlined,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Generate Itenary",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => InputPage()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 27,
                        backgroundImage:
                            NetworkImage('./assets/images/logo.jpg'),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Hello, ",
                              style: TextStyle(
                                color: kBlackClr,
                                fontSize: 18,
                              ),
                              children: [
                            TextSpan(
                                text: "$name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ])),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Interested in Travelling.',
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TypewriterAnimatedText('Need a travel plan ?',
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    TypewriterAnimatedText('You are at right place',
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                  onTap: () {
                    print("Tap Event");
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    decoration: BoxDecoration(
                        color: kWhiteClr,
                        borderRadius: BorderRadius.circular(100)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: "Enter the destination",
                                prefixIcon: Icon(Icons.search),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              child: IconButton(
                                  onPressed: (() {}),
                                  icon: const Icon(
                                    Icons.filter_alt,
                                    color: kWhiteClr,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      "Category",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 70,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          CategoryCard(
                            press: () {},
                            image: './assets/images/mountains.jpg',
                            title: 'Mountains',
                          ),
                          CategoryCard(
                            press: () {},
                            image: './assets/images/beach.jpg',
                            title: 'Beaches',
                          ),
                          CategoryCard(
                            press: () {},
                            image: './assets/images/forts.webp',
                            title: 'Forts',
                          ),
                          CategoryCard(
                            press: () {},
                            image: './assets/images/desert.jpg',
                            title: 'Desserts',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Text(
                      "Recommended",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 350,
                  child: ListView(
                    children: [
                      Row(
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              height: 320,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: kWhiteClr,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Container(
                                    height: 150,
                                    width: double.infinity,
                                    decoration: const BoxDecoration(),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
