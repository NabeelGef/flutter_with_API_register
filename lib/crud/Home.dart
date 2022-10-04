import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List notes = [
    {"note": "Message 1  ", "image": "Logo.jpg"},
    {"note": "Message 2  ", "image": "facebook.png"},
    {"note": "Message 3  ", "image": "facebook.png"},
    {"note": "Message 4  ", "image": "facebook.png"},
    {"note": "Message 5  ", "image": "facebook.png"}
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
        ),
        body: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return ListItem(notes: notes[index]);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed("addNotes");
          },
          child: Icon(Icons.add),
        ));
  }
}

class ListItem extends StatelessWidget {
  final notes;
  ListItem({this.notes});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Image.asset('images/${notes['image']}'),
          ),
          Expanded(
              flex: 3,
              child: ListTile(
                title: Text(notes['note']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {},
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
