import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/src/bloc/application_bloc.dart';
import 'package:todo_with_firebase/src/models/todo.dart';

import '../app.dart';

class DetailScreen extends StatefulWidget {
  final Todo todo;
  const DetailScreen({this.todo});
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  List<String> statusList = ['To Do', 'In Progress', 'Testing', 'Done'];
  int newStatus;

  final formKey = GlobalKey<FormState>();


  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();
  @override
  void initState() { 
    super.initState();
    newStatus = widget.todo.status;
    titleController.text = widget.todo.title;
    descController.text = widget.todo.descriptions;
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            elevation: 6.0,
            onPressed: () { 
              Provider.of<ApplicationBloc>(context, listen: false).deleteToDo(widget.todo.docId);
              Navigator.of(context).pop(); 
            },
            child: Icon(Icons.delete_outline_outlined, color: Colors.red)
            ),
      appBar: AppBar(
        title: Text('Просмотр'),
        backgroundColor: newStatus == 1 ? Colors.cyan[800] : newStatus == 2 ? Colors.red[800] : newStatus == 3 ? Colors.yellow[900] : Colors.lightBlue[800],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 14.0),
            child: Form(
              key: formKey,
                          child: Column(
                children: [
                  _buildTitleTextField(),
                  SizedBox(height: 30.0,),
                  _buildDescriptionsTextField(),
                  SizedBox(height: 30.0,),
                  DropdownButton(
                    hint: Text('Please choose a location'), // Not necessary for Option 1
                    value: statusList[newStatus],
                    onChanged: (newValue) {
                      setState(() {
                        switch(newValue){
                          case 'In Progress':
                            newStatus = 1;
                            break;
                          case 'Testing':
                            newStatus = 2;
                            break;
                          case 'Done':
                            newStatus = 3;
                            break;
                          default:
                            newStatus = 0;

                        }
                      });
                    },
                    items: statusList.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                        
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 30.0,),
                  
                  GestureDetector(
                      onTap: (){
                        if(formKey.currentState.validate()){
                          Provider.of<ApplicationBloc>(context, listen: false).updateToDo(Todo(docId: widget.todo.docId, author: widget.todo.author, title: titleController.text.trim(), descriptions: descController.text.trim(), status: newStatus));
              
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => App()));
                        }
                      },
                                    child: Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: newStatus == 1 ? Colors.cyan[800] : newStatus == 2 ? Colors.red[800] : newStatus == 3 ? Colors.yellow[900] : Colors.lightBlue[800],
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Center(
                          child: Text(
                          'Применить',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    )
                ],
              ),
            ),
          )
        ]
      )
    );
  }




    Widget _buildTitleTextField() {
    return TextFormField(
        controller: titleController,
            
        validator: (val) {
          return val.length > 5 ? null : 'Заголовок не должно быть меньше 5 символов!';
        },
        
        decoration: InputDecoration(
            
            hintText: 'Заголовок',
            hintStyle: TextStyle(color: Colors.grey[700], fontSize: 18.0),
        )
      );
  }


  Widget _buildDescriptionsTextField() {
    return TextFormField(
        controller: descController,
        
        validator: (val) {
          return val.length > 8 ? null : 'Описание не должно быть меньше 8 символов!';
        },
        decoration: InputDecoration(
            
            hintText: 'Описание',
            hintStyle: TextStyle(color: Colors.grey[700], fontSize: 18.0),
        )
      );
  }
}