import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final snapshot = await firestore.collection('recipes').get();
  for (var doc in snapshot.docs) {
    print('${doc.id}: ${doc.data()}');
  }
  print('Firebase initialized');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFFFFD60A),
      primary: const Color(0xFFFFD60A),
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Ricetta',
      theme: ThemeData(
        colorScheme: colorScheme,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
