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
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase CRUD Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green),
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.green[200],
      ),
      themeMode: ThemeMode.light,
      home: const MyHomePage(title: 'Firebase CRUD Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final CollectionReference _users = 
      FirebaseFirestore.instance.collection('users');

  // Future _update([]);
  // Future _create([]);
  // Future _delete([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    floatingActionButton: FloatingActionButton(
      onPressed: () => _create(),
      child: const Icon(Icons.add),
    ),
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: _users.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: ListTile(
                      title: Text(documentSnapshot['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Email: ${documentSnapshot['email']}'),
                          Text('Age: ${documentSnapshot['age']}'),
                        ],
                      ),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () =>
                              _update(documentSnapshot)
                          ),
                          IconButton(
                            icon: const Icon (Icons.delete),
                            onPressed: () =>
                              _delete(documentSnapshot.id)
                            ),
                        ],
                      )
                    )
                  ),
                  );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      )
    );
  }

  Future<void> _create() async {
    _nameController.clear();
    _emailController.clear();
    _ageController.clear();

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              ElevatedButton(
                child: const Text('Add'),
                onPressed: () async {
                  final String name = _nameController.text;
                  final String email = _emailController.text;
                  final int age = int.parse(_ageController.text);
                  await _users.add({"name": name, "email": email, "age": age});
                  _nameController.text = '';
                  _emailController.text = '';
                  _ageController.text = '';
                }
              ),
            ],
          ),
        );
      }
    );
  }


  Future<void> _update([DocumentSnapshot ? documentSnapshot]) async {
    if (documentSnapshot != null) {
      _nameController.text = documentSnapshot['name'];
      _emailController.text = documentSnapshot['email'];
      _ageController.text = documentSnapshot['age'].toString();
    }
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Age'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text ('Update'),
                onPressed: () async {
                  final String name = _nameController.text;
                  final String email = _emailController.text;
                  final int age = int.parse(_ageController.text);
                  await _users
                      .doc(documentSnapshot!.id)
                      .update({"name": name, "email": email, "age": age});
                }
              )
            ]
          ),
        );
      }
    );
  }

  Future<void> _delete(String id) async {
  await _users.doc(id).delete();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully deleted a user!'),
      ),
    );  
  }
}
