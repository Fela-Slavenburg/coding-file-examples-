import 'package:flutter/material.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BasicApp',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      home: const MyHomePage(title: 'NextApp'),
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
  int currentScreenIndex = 0;
 
  final screens = [
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipImage("assets/images/persoon.png"),
        SizedBox(height: 20),
        Text(
          "Mijn NextApp",
          style: TextStyle(fontSize: 30),
        ),
      ],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipImage("assets/images/flutter.png"),
        SizedBox(height: 20),
        Text(
          "Ik leer Flutter",
          style: TextStyle(fontSize: 30),
        ),
      ],
    ),
    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipImage("assets/images/dart.png"),
        SizedBox(height: 20),
        Text(
          "Explore Dart and Flutter",
          style: TextStyle(fontSize: 30),
        ),
      ],
    ),
  ];
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 199, 225, 246),
        title: Text(widget.title),
        leading: const Icon(Icons.menu),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= 600) {
            return Row(
              children: [
                NavigationRail(
                  selectedIndex: currentScreenIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      currentScreenIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorite'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.explore),
                      label: Text('Explore'),
                    ),
                  ],
                  labelType: NavigationRailLabelType.all,
                ),
                Expanded(child: screens[currentScreenIndex]),
              ],
            );
          } else {
            // BottomNavigationBar for smaller screens (portrait)
            return Column(
              children: [
                Expanded(child: screens[currentScreenIndex]),
                BottomNavigationBar(
                  currentIndex: currentScreenIndex,
                  onTap: (int index) {
                    setState(() {
                      currentScreenIndex = index;
                    });
                  },
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.favorite),
                      label: 'Favorite',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.explore),
                      label: 'Explore',
                    ),
                  ],
                ),
              ],
            );
          }
        },
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
      child: SizedBox.fromSize(
        size: const Size.fromRadius(90),
        child: Image.asset(
          _assetPath,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}