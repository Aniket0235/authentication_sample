import 'package:authentication_sample/Screens/HomePage.dart';
import 'package:authentication_sample/Screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailC = new TextEditingController();
  final TextEditingController passwordC = new TextEditingController();

  final _auth = FirebaseAuth.instance;

  Future<void> signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: "Login Successful"),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage()))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mailField = TextFormField(
        autofocus: false,
        controller: emailC,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Email");
          }
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          emailC.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    final passField = TextFormField(
        autofocus: false,
        controller: passwordC,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password");
          }
        },
        onSaved: (value) {
          passwordC.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
          child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 20),
                        SizedBox(
                            height: 200,
                            child: Image.asset(
                              "assets/images.png",
                              fit: BoxFit.contain,
                            )),
                        const SizedBox(height: 30),
                        mailField,
                        const SizedBox(height: 15),
                        passField,
                        const SizedBox(height: 15),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 60),
                              primary: Colors.cyan,
                              side: const BorderSide(
                                  width: 2, color: Colors.cyan),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16))),
                          onPressed: () {
                            signIn(emailC.text, passwordC.text);
                          },
                          child: const Text('LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const SignUp()));
                              },
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 16),
                              ),
                            )
                          ],
                        )
                      ]),
                ),
              )),
        )));
  }
}
