import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/view/home_screen.dart';
import 'package:todo/firebase_options.dart';
import 'package:todo/view/auth/login_screen.dart';

// FirebaseAuth.instance.authStateChanges()

void main() async { // Added async
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( // Added await
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // REMOVED 'const' from MaterialApp
    return MaterialApp( 
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 1. Handle Connection State (Optional but recommended)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // 2. Check if user is logged in
          if (snapshot.hasData) {
            return const HomeScreen(); // Added const here instead
          } else {
            return const LoginScreen(); // Added const here instead
          }
        },
      ),
    );
  }
}
