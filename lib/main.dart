import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> todos = [];
  TextEditingController todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'My Todo App',
          
        ),
      ),
      body: todos.isEmpty
        ? Center(
            child: Text(
              'no todos yet!',
              style: TextStyle(color: Colors.white),
            ),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(todos[index]),
                onDismissed: (direction) {
                  setState(() {
                    todos.removeAt(index);
                  });
                },
                child: Card(
                  color: Colors.grey[500],
                  child: ListTile(
                    title: Text(
                      todos[index],
                      style: TextStyle(color: Colors.white),
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
                  ),
                ),
              );
            },
          ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Todo'),
                content: TextField(
                  controller: todoController,
                  decoration: InputDecoration(
                    hintText: 'Enter a todo',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        todos.add(todoController.text);
                      });
                      todoController.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add, color: Colors.black),
      ),
    );
  }
}