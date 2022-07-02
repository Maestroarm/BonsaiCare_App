import 'main.dart';
import 'package:flutter/material.dart';
import 'tree_data.dart';
import 'user_pref.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class ListTrees extends StatefulWidget {
  const ListTrees({Key? key, required this.title, required this.trees}) : super(key: key);

  final Tree trees;
  final String title;

  @override
  State<ListTrees> createState() => _ListTreesState();
}

class _ListTreesState extends State<ListTrees> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
      body: Card(
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30)
        ),
        child: Container(
                margin: const EdgeInsets.all(30),
                child: Center(child:
                Column(
                  children: [
                    if (widget.trees.treeName != '')
                    Container(
                      width: 200,
                      height: 200,
                      margin: const EdgeInsets.only(bottom: 20),

                      child: widget.trees.image != null ? Image.file(
                        widget.trees.image!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fill,
                      ) :
                      const Image(
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        image: AssetImage('assets/bonsai_placeholder.png'),
                      ),
                    ),
                    if (widget.trees.treeName != '')
                      Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(top: 10),
                        child: Text('${widget.trees.treeName}'
                          '\nSpecies: ${widget.trees.species}'
                          '\nWatering Period: ${widget.trees.period}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                          ),),
                      ),
                  ],
                )
                ),
              ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: ()  {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(
                  title: 'My Bonsai Tree',
                  trees: Tree(widget.trees.treeName, widget.trees.species,
                      widget.trees.period, widget.trees.image))),
                (route) => false,);
          },
          child: const Icon(Icons.save_sharp),
        ) ,
    );
  }
}
