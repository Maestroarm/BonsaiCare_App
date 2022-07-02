import 'package:flutter/material.dart';
import 'dart:io';
import 'list_trees.dart';
import 'tree_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';


class AddTree extends StatefulWidget {
  const AddTree({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<AddTree> createState() => _AddTreeState();
}

class _AddTreeState extends State<AddTree> {

  final _textController = TextEditingController();
  String dropdownValue = 'Other';
  String dropdownValue2 = 'Every three days';
  String treeName = "Tree Name";
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      
      final imagePermanent = await saveImagePermanently(image.path);

      setState(() {
        this.image = imagePermanent;
      });
    } on Platform catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImagePermanently(String imagePath) async{
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 150,
              height: 150,
              margin: const EdgeInsets.only(bottom: 20),

              child: image != null ? Image.file(
                  image!,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
              ) :
              const Image(
                image: AssetImage('assets/bonsai_placeholder.png'),
              ),
            ),
            SizedBox(
              width: 150,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue
                ),
                onPressed: () {
                  pickImage();
                },

                child: Wrap(
                  children: const <Widget>[
                    Icon(
                      Icons.photo,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Add Photo", style:TextStyle(fontSize:18)),
                  ],
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 10),
              child: TextField(
                controller: _textController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Tree Name',
                  suffixIcon: IconButton(
                    onPressed: () {
                      //clear
                      _textController.clear();
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                alignment: Alignment.bottomLeft,
                child: const
                Text('Watering Period')
            ),
            Container(
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue2,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.blueGrey),
                underline: Container(
                  height: 2,
                  color: Colors.lightGreen,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue2 = newValue!;
                  });
                },
                items: <String>['Every three days', 'Every four days', 'Every week']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                alignment: Alignment.bottomLeft,
                child: const
                Text('Species')
            ),
        Container(
          margin: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
          child: DropdownButton<String>(
            isExpanded: true,
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: const TextStyle(color: Colors.blueGrey),
            underline: Container(
              height: 2,
              color: Colors.lightGreen,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['Broadleaf', 'Deciduous', 'Pine', 'Conifer', 'Other']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // background
                  onPrimary: Colors.white, // foreground
                ),
                onPressed: () {
                  if (_textController.text != '') {
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListTrees(
                        title: 'My Bonsai Tree',
                        trees: Tree(_textController.text, dropdownValue,
                            dropdownValue2, image))),
                  );
                  }
                },
                child: const Text('NEXT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}