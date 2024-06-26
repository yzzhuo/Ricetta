import 'package:Ricetta/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/screens/login_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userProvider);
    return Scaffold(
      body: asyncUser.when(
        data: (user) {
          return user == null
              ? const LoginScreen()
              : const PorfileContentScreen();
        },
        error: (error, stackTrace) {
          return const Center(child: Text("Something went wrong.."));
        },
        loading: () {
          return const Center(child: Text("Loading..."));
        },
      ),
    );
  }
}

class PorfileContentScreen extends StatelessWidget {
  const PorfileContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Profile Content"),
    );
  }
}
