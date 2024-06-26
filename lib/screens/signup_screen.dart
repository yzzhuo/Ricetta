import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final emailInputController = TextEditingController();
  final passwordInputController = TextEditingController();

  alert(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  handleSignup() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailInputController.text,
        password: passwordInputController.text,
      );
      alert('Account created successfully');
      Future.delayed(const Duration(seconds: 2), () {
        context.push('/profile');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        alert('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        alert('The account already exists for that email.');
      }
    } catch (e) {
      alert(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Sign up',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
              )),
          const SizedBox(height: 80),
          SizedBox(
              width: double.infinity,
              child: Column(children: [
                TextField(
                    controller: emailInputController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft:
                              Radius.circular(0.0), // Minimize bottom effect
                          bottomRight:
                              Radius.circular(0.0), // Minimize bottom effect
                        ),
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Email Address',
                      filled: true,
                      fillColor: Colors.white,
                    )),
                TextField(
                    controller: passwordInputController,
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft:
                              Radius.circular(4.0), // Minimize bottom effect
                          bottomRight:
                              Radius.circular(4.0), // Minimize bottom effect
                        ),
                        borderSide: BorderSide(color: Colors.grey, width: 0.0),
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                    )),
                const SizedBox(height: 26),
                MaterialButton(
                  minWidth: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                  color: Theme.of(context).colorScheme.primary,
                  child: const Text(
                    'Continue',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () async {
                    handleSignup();
                  },
                ),
              ])),
        ],
      ),
    )));
  }
}
