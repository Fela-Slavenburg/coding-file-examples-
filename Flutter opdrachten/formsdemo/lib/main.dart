import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark
      ),
      themeMode: ThemeMode.dark,
      home: MyHomePage(title: appTitle),
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
        title: Text(widget.title),
      ),
      body : const DemoForm(),
    );
  }
}

class DemoForm extends StatefulWidget {
  const DemoForm({super.key});

  @override
  _DemoFormState createState() {
    return _DemoFormState(); 
  }
}

class _DemoFormState extends State<DemoForm> {
  final _formKey = GlobalKey<FormState>();
  bool? _terms = false;
  int? _student = -1;
  String _woonplaats = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,

      child: Container(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // naam input
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Wat is uw naam?',
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Voer uw naam in';
                }
                return null;
              },
            ),
            // email input
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Voer uw email in',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Voer uw email in';
                }
                return null;
              },
            ), 
            // leeftijd input
            TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Wat is uw leeftijd?',
              ),

              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Voer uw leeftijd in';
                }
                return null;
              },
            ),
            // agree to terms
            CheckboxListTile(
              title: Text('I agree to terms'),

              value: _terms,
              onChanged:(value) => setState(() => _terms = value),

                subtitle: _terms == false ?
                Padding(
                  padding: EdgeInsets.fromLTRB(12.0, 0, 0, 0),
                  child: Text(
                    'Required field',
                    style: TextStyle(color:Color(0xFFe53935), fontSize: 12),
                  ),
                )
                : null,
            ),
            // student of niet check
            RadioListTile<int>(
              title: Text('Ja ik ben student'),
              value: 1, 
  	          groupValue: _student,
              onChanged: (int? value) => setState(() => _student = value)
            ),
            RadioListTile<int>(
              title: Text('Nee'),
              value: 0, 
  	          groupValue: _student,
              onChanged: (int? value) => setState(() => _student = value)
            ),
            // woonplaats selecteren
            DropdownButtonFormField(
              value: _woonplaats,
              items: [
                DropdownMenuItem<String>(
                  child: Text('Kies een stad'), value: ''),
                DropdownMenuItem<String>(
                  child: Text('Amsterdam'), value: 'Amsterdam'),
                DropdownMenuItem<String>(
                  child: Text('Brussel'), value: 'Brussel'),
                DropdownMenuItem<String>(
                  child: Text('Barcelona'), value: 'Barcelona'),
              ],
              onChanged: (String? value) {
                setState(() {
                  _woonplaats = value!;
                });
              }
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

