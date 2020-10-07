import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const platform = const MethodChannel('ristek-channel/send_message');
  String message = '';
  List<dynamic> notes;
  String newNotes = '';
  bool isSuccessSave = false;
  TextEditingController controller = TextEditingController();

  Future<void> getNotes() async {
    List<dynamic> response;

    try {
      final String result = await platform.invokeMethod('get-all-message');
      response = jsonDecode(result);
    } on PlatformException catch (e) {
      response = null;
    }

    setState(() {
      notes = response;
    });
  }

  Future<void> saveNotes() async {
    String response = '';

    try {
      final String result =
          await platform.invokeMethod('save-message', {"message": newNotes});
      response = result;
    } on PlatformException catch (e) {
      response = "Failed to connect : ${e.message}";
    }

    if (response == "SUCCESS") {
      controller.clear();
      setState(() {
        newNotes = '';
        isSuccessSave = true;
      });
    } else {
      print("error saving");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("RistekChannel"),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: (String value) {
                setState(() {
                  newNotes = value;
                });
              },
            ),
            RaisedButton(
              child: Text("Save notes"),
              onPressed: saveNotes,
            ),
            isSuccessSave ? Text("Success saving !") : Container(),
            RaisedButton(
              child: Text("Press to Call Notes"),
              onPressed: getNotes,
            ),
            Expanded(
              child: Container(
                child: ListView(children: [
                  Column(
                    children: notes != null
                        ? notes.map((e) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(e['value']),
                                        Text(e['date']),
                                      ],
                                    ),
                                    Divider(),
                                  ],
                                ),
                              ),
                            );
                          }).toList()
                        : [],
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
