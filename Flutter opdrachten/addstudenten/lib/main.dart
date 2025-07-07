import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'firebase collection',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Firebase Collection'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _addStudenten() {
    setState(() {
    
    final CollectionReference _studenten =
        FirebaseFirestore.instance.collection('studenten');

        final studenten2 = <String, dynamic>{
          "naam": "Joshua",
          "email": "joshua@hotmail.com",
          "leeftijd": 19,
          "land": "Belgie",
          "opleiding": "Handel",
          "creditcard": true,
          "date": Timestamp.now(),
        };
        _studenten.doc().set(studenten2);

        final studenten3 = <String, dynamic>{
          "naam": "Jules",
          "email": "jules@hotmail.com",
          "leeftijd": 17,
          "land": "Spanje",
          "opleiding": "Software Developer",
          "creditcard": true,
          "date": Timestamp.now(),
        };
        _studenten.doc().set(studenten3);

        final studenten4 = <String, dynamic>{
          "naam": "Fela",
          "email": "fela@hotmail.com",
          "leeftijd": 18,
          "land": "Nederland",
          "opleiding": "Software Developer",
          "creditcard": false,
          "date": Timestamp.now(),
        };
        _studenten.doc().set(studenten4);

        final studenten5 = <String, dynamic>{
          "naam": "Nigel",
          "email": "nigel@hotmail.com",
          "leeftijd": 19,
          "land": "Nederland",
          "opleiding": "Front Desk Managment",
          "creditcard": false,
          "date": Timestamp.now(),
        };
        _studenten.doc().set(studenten5);

        final studenten6 = <String, dynamic>{
          "naam": "Luca",
          "email": "luca@hotmail.com",
          "leeftijd": 19,
          "land": "Nedreland",
          "opleiding": "Stewartess",
          "creditcard": true,
          "date": Timestamp.now(),
        };
        _studenten.doc().set(studenten6);

        final studenten7 = <String, dynamic>{
          "naam": "Abi",
          "email": "abi@hotmail.com",
          "leeftijd": 19,
          "land": "Nederland",
          "opleiding": "Game designer",
          "creditcard": true,
          "date": Timestamp.now(),
        };
        _studenten.doc().set(studenten7);
    });
  }

    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addStudenten,
        tooltip: 'Add studenten',
        child: const Icon(Icons.add),
      ),
    );
  }
}
