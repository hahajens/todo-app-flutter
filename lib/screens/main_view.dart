import 'package:app_todo/screens/second_view.dart';
import 'package:flutter/material.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      appBar: AppBar(
        // backgroundColor: Colors.grey[600],
        title: Text(
          "To-do",
        ),
        actions: [
          _dropdownMenu(),
        ],
      ),
      body: ListView(
        children: [
          _checkboxListTodo("tvätta"),
          _checkboxListTodo("städa"),
          _checkboxListTodo("springa"),
          _checkboxListTodo("träna"),
          _checkboxListTodo("tvätta"),
          _checkboxListTodo("städa"),
          _checkboxListTodo("springa"),
          _checkboxListTodo("Ta bort mitt repo"),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
          //backgroundColor: Colors.blueGrey[400],
          onPressed: () {
            print("flytknapp funkar");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SecondView()));
          },
        ),
      ),
    );
  }
}

//Dropdown-meny med filtreringalternativ, ingen funktion annat är prints
Widget _dropdownMenu() {
  List<String> choices = ["All", "Done", "Not done"];

  return Padding(
    padding: const EdgeInsets.only(right: 15.0),
    child: PopupMenuButton<String>(
      icon: Icon(
        Icons.tune_rounded,
      ),
      onSelected: choiceAction,
      itemBuilder: (BuildContext context) {
        return choices.map((String choice) {
          return PopupMenuItem(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    ),
  );
}

//Kollar så att knapparna i drop down fungerar
void choiceAction(String choice) {
  if (choice == "All") {
    print("You pressed: All");
  } else if (choice == "Done") {
    print("You pressed: Done");
  } else if (choice == "Not done") {
    print("You pressed: Not done");
  }
}

//genererar nytt todo-element
Widget _checkboxListTodo(String toDo) {
  // bool checkboxValue = false;
  return Padding(
    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
    child: Card(
      // color: Colors.grey[500],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: CheckboxListTile(
          title: Text(
            toDo,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          ),
          secondary: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              print("trash");
            },
          ),
          controlAffinity: ListTileControlAffinity.leading,
          value: false,
          onChanged: (value) {
            print("You pressed checkbox");
          }),
    ),
  );
}
