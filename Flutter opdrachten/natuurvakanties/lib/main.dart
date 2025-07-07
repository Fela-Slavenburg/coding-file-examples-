import 'package:flutter/material.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Natuur vakanties',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Natuur vakanties'),
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

  List<Map<String, dynamic>> vakantieLijst = [
    {
      "image": "https://picsum.photos/id/15/200/300",
      "bestemming": "Frankrijk",
      "prijs": 90,
      "reviews": 15,
    },
    {
      "image": "https://picsum.photos/id/28/200/300",
      "bestemming": "Oostenrijk",
      "prijs": 100,
      "reviews": 10,
    },
    {
      "image": "https://picsum.photos/id/74/200/300",
      "bestemming": "Nederland",
      "prijs": 80,
      "reviews": 65,
    },
    {
      "image": "https://picsum.photos/id/27/200/300",
      "bestemming": "Egypte",
      "prijs": 120,
      "reviews": 40,
    },
    {
      "image": "https://picsum.photos/id/14/200/300",
      "bestemming": "Ireland",
      "prijs": 40,
      "reviews": 80,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Natuurvakanties"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SizedBox(
        height: 280,
        child: ScrollSnapList(
          itemBuilder: vakantieItemBuilder,
          itemCount: vakantieLijst.length,
          itemSize: 250,
          onItemFocus: (index) {},
          dynamicItemSize: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget vakantieItemBuilder(BuildContext context, int index) {
    Map vakantie = vakantieLijst[index];
    return SizedBox(width: 250, height: 400,
      child: Card(
        margin: EdgeInsets.all(15.0),
        elevation: 12,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Column(
            children: [
              Image.network(
                vakantie["image"],
                fit: BoxFit.cover,
                height: 180, width: 150,
              ),
              const SizedBox(height: 10),
              Text(vakantie['bestemming'], style: const TextStyle(fontSize: 15)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prijs ${vakantie['prijs']}',
                      style: const TextStyle(fontWeight: FontWeight.bold)
                    ),
                    Text(
                      '${vakantie['reviews']} Reviews',
                      style: const TextStyle(color: Colors.blue,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
