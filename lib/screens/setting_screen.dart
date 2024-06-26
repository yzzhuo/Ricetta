import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:Ricetta/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    if (user == null) {
      context.push('/signup');
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings',
              style: TextStyle(
                color: Colors.black,
                fontSize: 34,
                fontWeight: FontWeight.w700,
              )),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              context.pop();
            },
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Account',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    )),
                const SizedBox(height: 20),
                Expanded(
                    child: ListView(children: [
                  _tile('Uid', user!.uid),
                  _tile('Email', user.email ?? 'Empty'),
                  const SizedBox(height: 80),
                  MaterialButton(
                    minWidth: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                    color: Colors.black,
                    child: const Text(
                      'Sign out',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      await Future.delayed(const Duration(seconds: 1), () {
                        context.push('/profile');
                      });
                    },
                  ),
                ])),
              ],
            )));
  }
}

Widget _tile(String title, String value) {
  return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
            Text(value,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                )),
          ]));
}
