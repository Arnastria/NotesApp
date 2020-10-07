import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  List<dynamic> notes;
  TextEditingController controller = TextEditingController();

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
            ),
            RaisedButton(
              child: Text("Save notes"),
              onPressed: () {},
            ),
            RaisedButton(
              child: Text("Press to Call Notes"),
              onPressed: () {},
            ),
            Expanded(
              child: Container(
                child: ListView(
                  children: [
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
