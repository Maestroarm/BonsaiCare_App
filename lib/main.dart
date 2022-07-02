import 'package:flutter/material.dart';
import 'add_tree.dart';
import 'list_trees.dart';
import 'tree_data.dart';
import 'user_pref.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BonsaiCare',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Bonsai Care', trees: Tree('', '',
          '', null)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.trees}) : super(key: key);

  final String title;
  final Tree trees;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 450,
              height: 450,
              margin: const EdgeInsets.only(bottom: 20),

              child: const Image(
                  image: AssetImage('assets/bonsai-tree.png'),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 0),
              alignment: Alignment.bottomCenter,

              child:
              const Text(
                  'Welcome to Bonsai Care!',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  )
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              alignment: Alignment.bottomCenter,

              child:
              const Text(
                  'Tap the plus button to add a new bonsai tree OR menu button to view your bonsai tree',
                  style: TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 50),
              alignment: Alignment.bottomLeft,

              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListTrees(
                        title: 'My Bonsai Tree',
                        trees: Tree(widget.trees.treeName, widget.trees.species,
                            widget.trees.period, widget.trees.image))),
                  );

                },
                child: const Icon(Icons.menu),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTree(
                title: 'Add a New Bonsai Tree')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
