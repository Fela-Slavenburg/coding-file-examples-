import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DataTable',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter DataTable'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        
        child: SingleChildScrollView(
          
          child: (DataTable(
            sortColumnIndex: 0,
            sortAscending: true,
            headingRowColor: 
            WidgetStateProperty.all(const Color.fromARGB(255, 210, 178, 230)),
            columns: [
              DataColumn(label: Text('Naam', style: TextStyle(fontStyle: FontStyle.italic))),
              DataColumn(label: Text('Email', style: TextStyle(fontStyle: FontStyle.italic))),
              DataColumn(label: Text('Woonplaats', style: TextStyle(fontStyle: FontStyle.italic))),
              DataColumn(label: Text('Leeftijd', style: TextStyle(fontStyle: FontStyle.italic)), numeric: true),
            ],

            rows: [
              DataRow(cells: [
                DataCell(Text('Dash')),
                DataCell(Text('dash@gmail.com')),
                DataCell(Text('Almere')),
                DataCell(Text('18'), showEditIcon: true),
              ]),
              DataRow(cells: [
                DataCell(Text('Fela')),
                DataCell(Text('fela@gmail.com')),
                DataCell(Text('Amsterdam')),
                DataCell(Text('18'), showEditIcon: true),
              ]),
              DataRow(cells: [
                DataCell(Text('Nigel')),
                DataCell(Text('nogek@gmail.com')),
                DataCell(Text('Amsterdam')),
                DataCell(Text('19'), showEditIcon: true),
              ]),
              DataRow(cells: [
                DataCell(Text('Luca')),
                DataCell(Text('lucaaa@gmail.com')),
                DataCell(Text('Amsterdam')),
                DataCell(Text('20'), showEditIcon: true),
              ]),
            ],
            
          ))
        )
      )
    );
  }
}
