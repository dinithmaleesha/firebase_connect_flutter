import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FirebaseInitWidget(),
    );
  }
}

class FirebaseInitWidget extends StatelessWidget {
  Future<String> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
      print('Firebase is initialized');
      return 'Firebase is initialized';
    } catch (e) {
      print('Failed to initialize Firebase: $e');
      return 'Failed to initialize Firebase';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return MyHomePage(status: snapshot.data ?? 'Unknown error');
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String status;

  MyHomePage({required this.status});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Firebase Demo'),
      ),
      body: Center(
        child: Text(
          status,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
