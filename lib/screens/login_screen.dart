import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Log in',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
              )),
          const SizedBox(height: 80),
          SizedBox(
              width: double.infinity,
              child: Column(children: [
                TextFormField(
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
                TextFormField(
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
                  onPressed: () async {},
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          context.push('/signup');
                        },
                        child: const Text('Sign up',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ))),
                    const Text('for a new account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ))
                  ],
                )
              ])),
          const SizedBox(height: 26),
          const LoginMethodDivider(),
          const SizedBox(height: 26),
          const LoginAnonymousButton(),
        ],
      ),
    )));
  }
}

class LoginMethodDivider extends StatelessWidget {
  const LoginMethodDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('OR'),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class LoginAnonymousButton extends StatelessWidget {
  const LoginAnonymousButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
      color: Colors.black,
      child: const Text(
        'Login anonymously',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onPressed: () async {
        await FirebaseAuth.instance.signInAnonymously();
      },
    );
  }
}
