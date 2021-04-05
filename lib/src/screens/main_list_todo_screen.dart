import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/src/bloc/application_bloc.dart';
import 'package:todo_with_firebase/src/models/todo.dart';
import 'package:todo_with_firebase/src/screens/add_screen.dart';
import 'package:todo_with_firebase/src/screens/detail_screen.dart';

import 'package:todo_with_firebase/src/screens/profile_screen.dart';

class MainListTodoScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void _openDrawer() {
  _scaffoldKey.currentState.openDrawer();
}

void _closeDrawer() {
  Navigator.of(context).pop();
}

    final textStyleForTitle = TextStyle(
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold
    );
    final textStyleForSubtitle = TextStyle(
      color: Colors.white,
      fontSize: 15.0,
      fontWeight: FontWeight.w600
    );
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Container(
            width: MediaQuery.of(context).size.width/1.5,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListView(children: [
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ProfileScreen()));
                  },
                                  child: Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
                    child: Row(
                      children: [
                        Icon(Icons.person),
                        SizedBox(width: 13.0),
                        Text('Профиль', style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold))
                      ]
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                                  child: Container(
                    color: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 14.0),
                    child: Row(
                      children: [
                        Icon(Icons.list_alt_outlined),
                        SizedBox(width: 13.0),
                        Text('Дела', style: TextStyle(color: Colors.black, fontSize: 22.0, fontWeight: FontWeight.bold))
                      ]
                    ),
                  ),
                ),
                
                
              ],),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            
            elevation: 6.0,
            onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => AddScreen())); },
            child: Icon(Icons.add)
            ),
          appBar: AppBar(
            elevation: 4.0,
            leading: GestureDetector(
            
            onTap: (){
              _openDrawer();
            },
                      child: Icon(
              Icons.menu,
              size: 32.0,
              color: Colors.white,
            ),
          ),

            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.today_outlined)),
                Tab(icon: Icon(Icons.trending_up)),
                Tab(icon: Icon(Icons.build_outlined)),
                Tab(icon: Icon(Icons.done)),
              ],
            ),
            title: Text('ToDo app'),
          ),
          body: Consumer<ApplicationBloc>(
            builder: (context, appBloc, child){
              switch(appBloc.listTodoState){
                case listTodoStateEnum.isLoading:
                  return Center(child: CircularProgressIndicator());
                  break;
                case listTodoStateEnum.isEmpty:
                  return Center(child: Text('У вас нет дел!'));
                  break;
                case listTodoStateEnum.isNotEmprty:
                  List<Todo> toDoList = appBloc.todos.where((i) => i.status == 0).toList();
                  List<Todo> inProgressList = appBloc.todos.where((i) => i.status == 1).toList();
                  List<Todo> testingList = appBloc.todos.where((i) => i.status == 2).toList();
                  List<Todo> doneList = appBloc.todos.where((i) => i.status == 3).toList();

                  return TabBarView(
                  
              children: [

                //To Do
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                              itemCount: toDoList == null ? 0 : toDoList.length,
                              itemBuilder: (context, index){
                                
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailScreen(todo: toDoList[index])));
                                    },
                                    child: Card(
                                      elevation: 8.0,
                                      color: Colors.lightBlue[800],
                                      child: ListTile(
                                        title: Text(toDoList[index].title, style: textStyleForTitle),
                                        subtitle: Text(toDoList[index].descriptions, style: textStyleForSubtitle),
                                      ),
                                    ),
                                  );
                                
                              },
                            ),
                ),






                
                

                // In Progress
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                              itemCount: inProgressList.length == null ? 0 : inProgressList.length,
                              itemBuilder: (context, index){
                                
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailScreen(todo: inProgressList[index])));
                                    },
                                    child: Card(
                                      elevation: 8.0,
                                      color: Colors.cyan[800],
                                      child: ListTile(
                                        title: Text(inProgressList[index].title, style: textStyleForTitle),
                                        subtitle: Text(inProgressList[index].descriptions, style: textStyleForSubtitle),
                                      ),
                                    ),
                                  );
                                
                              },
                            ),
                ),

               


                // Testing
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                              itemCount: testingList.length == null ? 0 : testingList.length,
                              itemBuilder: (context, index){
                                
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailScreen(todo: testingList[index])));
                                    },
                                    child: Card(
                                      elevation: 8.0,
                                      color: Colors.red[800],
                                      child: ListTile(
                                        title: Text(testingList[index].title, style: textStyleForTitle),
                                        subtitle: Text(testingList[index].descriptions, style: textStyleForSubtitle),
                                      ),
                                    ),
                                  );
                                
                              },
                            ),
                ),


                
                // Done
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                              itemCount: doneList.length == null ? 0 : doneList.length,
                              itemBuilder: (context, index){
                                
                                  return GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => DetailScreen(todo: doneList[index])));
                                    },
                                    child: Card(
                                      elevation: 8.0,
                                      color: Colors.yellow[900],
                                      child: ListTile(
                                        title: Text(doneList[index].title, style: textStyleForTitle),
                                        subtitle: Text(doneList[index].descriptions, style: textStyleForSubtitle),
                                      ),
                                    ),
                                  );
                                
                              },
                            ),
                ),
                
              ],
            );
                  break;
                default:
                  return Center(child: Text('Что то пошло не так!'));
              }
                
                
            }
          ),
        ),
      );
  }
}