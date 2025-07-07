import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future <void> main() async {
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
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  var query1 =
  FirebaseFirestore.instance
  .collection('studenten')
  .snapshots();

  var query2 = 
  FirebaseFirestore.instance
  .collection('studenten')
  .orderBy('naam')
  .snapshots();

  var query3 =
  FirebaseFirestore.instance
  .collection('studenten')
  .where('leeftijd', isGreaterThan: 18)
  .snapshots();

  var query4 =
  FirebaseFirestore.instance
  .collection('studenten')
  .where('leeftijd', isLessThan: 18)
  .where('land', isEqualTo: 'Spanje')
  .snapshots();

  var query5 =
  FirebaseFirestore.instance
  .collection('studenten')
  .where('creditcard', isEqualTo: true)
  .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: query5,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Error: ${snapshot.error}');
            }    
                return DataTable(
                headingRowColor: WidgetStateProperty.all(
                  const Color.fromARGB(255, 192, 246, 209),
                ),

                columns: [
                  DataColumn(label: Text('Naam', style: TextStyle(fontSize: 16))),
                  DataColumn(label: Text('Email', style: TextStyle(fontSize: 16))),
                  DataColumn(label: Text('Leeftijd', style: TextStyle(fontSize: 16))),
                  DataColumn(label: Text('Land', style: TextStyle(fontSize: 16))),
                  DataColumn(label: Text('Opleiding', style: TextStyle(fontSize: 16))),
                  DataColumn(label: Text('Creditcard', style: TextStyle(fontSize: 16))),
                ],
                rows: _buildList(context, snapshot.data!.docs),
              );
            return LinearProgressIndicator();
          },
        ),
      ),
    );
  }

  List<DataRow> _buildList(
    BuildContext context,
    List<DocumentSnapshot> snapshot,
  ) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
  final student = data.data() as Map<String, dynamic>;
  return DataRow(
    cells: [
      DataCell(Text(student['naam'] ?? '', style: TextStyle(fontSize: 16))),
      DataCell(Text(student['email'] ?? '', style: TextStyle(fontSize: 16))),
      DataCell(Text('${student['leeftijd'] ?? ''}', style: TextStyle(fontSize: 16))),
      DataCell(Text(student['land'] ?? '', style: TextStyle(fontSize: 16))),
      DataCell(Text(student['opleiding'] ?? '', style: TextStyle(fontSize: 16))),
      DataCell(Text(student['creditcard'] == true ? "Ja" : "Nee")),
    ],
  );
}
}

