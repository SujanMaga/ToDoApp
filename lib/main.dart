import 'package:flutter/material.dart';

void main() {
  runApp(MyWidget());
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _textController = TextEditingController();
  String work = "Whatever";
  List<String> todos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.green,
        title: Text("ToDo App"),
        centerTitle: true,
      ),
      body: Column(children: [
        SizedBox(height: 10),
        TextField(
          controller: _textController,
          decoration: InputDecoration(
            hintText: "Enter the task",
            border: OutlineInputBorder(),
            suffix: IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    todos.add(work);
                  });
                  _textController.clear();
                }),
          ),
          onChanged: (value) {
            setState(() {
              work = value;
            });
          },
        ),
        SizedBox(height: 70),
        if (todos.isNotEmpty)
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    todos[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  leading: IconButton(
                    icon: Icon(Icons.edit),
                    color: Colors.black,
                    onPressed: () async {
                      String editedText = todos[index];
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Edit ToDo"),
                              content: TextFormField(
                                  initialValue: todos[index],
                                  onChanged: (value) {
                                    editedText = value;
                                  }),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("Edit"))
                              ],
                            );
                          });

                      setState(() {
                        todos[index] = editedText;
                      });
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() {
                        todos.removeAt(index);
                      });
                    },
                  ),
                  tileColor: Colors.green,
                );
              },
              itemCount: todos.length,
              separatorBuilder: (context, index) {
                return SizedBox(height: 2);
              },
            ),
          )
        else
          Text("Nothing to show"),
      ]),
    );
  }
}
