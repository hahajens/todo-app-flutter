import 'package:app_todo/model.dart';
import 'package:app_todo/screens/second_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[300],
      appBar: AppBar(
        // backgroundColor: Colors.grey[600],
        title: Text(
          "Uppgifter",
        ),
        actions: [
          DropdownMenu(),
        ],
      ),
      body: MyListView(),
      //ToDoList([
      //   ToDoObject(toDo: "Träna"),
      //   ToDoObject(toDo: "Springa"),
      // ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(18.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Colors.blueGrey,
          onPressed: () async {
            print("flytknapp funkar");

            var newObject = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => SecondView()));

            if (newObject != '') {
              Provider.of<Model>(context, listen: false).addToList(newObject);
            }
          },
        ),
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<Model>(
      builder: (context, state, child) => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: state.list.length,
          itemBuilder: (BuildContext context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: CheckboxListTile(
                activeColor: Colors.black,
                checkColor: Colors.white,
                value: state.getCheckbox(index),
                onChanged: (bool newValue) {
                  state.setCheckbox(index, newValue);
                  // Provider.of<Model>(context, listen: false).setCheckbox(index);
                },
                title: Text(
                  state.list[index].toDo,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                secondary: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    state.removeFromList(state.list[index]);
                  },
                ),
                controlAffinity: ListTileControlAffinity.leading,
              ),
            );
          }),
    );
  }
}

//Dropdown-meny med filtreringalternativ, ingen funktion annat är prints

class DropdownMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Icon _icon = Icon(Icons.more_vert);
    return Consumer<Model>(
      builder: (context, state, child) => PopupMenuButton(
        icon: _icon,
        itemBuilder: (context) => [
          PopupMenuItem(
            child: ListTile(
              title: Text("All"),
              onTap: () {
                state.filteredList("All");
                print("all");
                Navigator.pop(context);
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text("Done"),
              //true
              onTap: () {
                state.filteredList("Done");
                Navigator.pop(context);
                print("done");
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text("Undone"),
              //false
              onTap: () {
                state.filteredList("Undone");
                print("undone");
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
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
