import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gemeente App',
      theme: ThemeData(
        useMaterial3: true, 
        colorSchemeSeed: const Color.fromARGB(255, 232, 20, 20),
     ),
      home: const MyHomePage(title: 'Werkzaamheden'),
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
  int _selectedIndex = 0;
  double _thumbs = 0;

  final List<Widget> screens = [
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          child: const Image (image: 
          AssetImage('assets/images/werkzaamhedenbord.png')
          )
        ),
        const Text(
          "in je buurt",
          style: TextStyle(fontSize: 30),
          selectionColor: Color.fromARGB(0, 0, 0, 0),
          textAlign: TextAlign.center
        ),
      ],
    ),
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(

        ),
      ],
    ),
  ];

void changeDestination(int index) {
    setState(() {
      _selectedIndex = index;
    });
}

void _incrementThumbs() {
    setState(() {
      _thumbs += 1;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 218, 26, 26),
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white, fontSize: 30, )
          ),
      ),
        body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          screens[_selectedIndex],
          IconButton(
            icon: const Icon(Icons.thumb_up_outlined),
            tooltip: 'Duimpje omhoog',
            color: const Color.fromARGB(255, 218, 26, 26),
            onPressed: _incrementThumbs,
          ),
          Text(
          '$_thumbs', 
          style: const TextStyle(
            fontSize: 30, 
            color: Color.fromARGB(255, 218, 26, 26)),
          ),
        ],
      ),  
        bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: changeDestination,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, 
            color: Colors.white,
            size: 40),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on, 
            color: Colors.black,
            size: 40),
            label: 'Location',
          ),
        ],
        showSelectedLabels: false, 
        showUnselectedLabels: false, 
        backgroundColor:  const Color.fromARGB(255, 218, 26, 26),   
      ),
    );
  }
}

class ClipImage extends StatelessWidget {
  final String _assetPath;
  const ClipImage(this._assetPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child:SizedBox.fromSize(
        size: const Size.fromRadius(144),
        child: Image.asset(
          _assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

