import 'dart:convert' as convert;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_with_firebase/helpers/helperfunctions.dart';
import 'package:todo_with_firebase/src/models/todo.dart';


class TodoService{
  CollectionReference todos = FirebaseFirestore.instance.collection('todos');


  //List for return!
  List<Todo> todoList = [];
  

  //Insert todo to Firebase
  Future addToDo(String title, String descriptions) async {
    try{
      String email = await HelperFunctions.getUserEmailSharedPreference();
      todos.add({
        'title': title,
        'descriptions': descriptions,
        'status': 0,
        'author': email
      });
      return true;
    }catch(e){
      print(e.toString());
      
      return false;
    }
  }


  //Getting all todos from user account
  Future fetchToDos() async {
    try{ 
      todoList = [];
      String email = await HelperFunctions.getUserEmailSharedPreference();
      QuerySnapshot eventsQuery = await todos
      .where("author", isEqualTo: email)
      .get().then((value) {
        
        value.docs.forEach((element) {
          
          Todo todo = Todo(
            docId: element.id,
            title: element['title'],
            descriptions: element['descriptions'],
            status: element['status'],
            author: element['author']
          );

          todoList.add(todo);
        });
        print(email);
      });
      return todoList;
    }catch(e){
      print(e.toString());
    }
  }


  //Update todo
  Future updateToDo(Todo todo) async {
    try{
      await todos.doc(todo.docId).update(
        {
          'title': todo.title,
          'descriptions': todo.descriptions,
          'status': todo.status,

        }
      );
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }


  //Delete todo by document ID
  Future deleteToDo(String docId) async {
    try{
      await todos.doc(docId).delete();
    }catch(e){
      print(e.toString());
    }
  }
}