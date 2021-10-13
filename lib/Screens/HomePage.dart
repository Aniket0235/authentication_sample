// ignore_for_file: file_names

import 'package:authentication_sample/Screens/login_page.dart';
import 'package:authentication_sample/models/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  User? user = FirebaseAuth.instance.currentUser;
  userModel loggedInUser = userModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Uid")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = userModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                SizedBox(
                    height: 200,
                    child: Image.asset(
                      "assets/images.png",
                      fit: BoxFit.contain,
                    )),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  "Welcome ${loggedInUser.fullname}",
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      primary: Colors.cyan,
                      side: const BorderSide(width: 2, color: Colors.cyan),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16))),
                  onPressed: () {
                    logout(context);
                  },
                  child: const Text('Log Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
