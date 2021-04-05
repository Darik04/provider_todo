
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/src/bloc/application_bloc.dart';

import '../app.dart';

class AddScreen extends StatelessWidget {

  final formKey = GlobalKey<FormState>();
  


  TextEditingController titleController = new TextEditingController();
  TextEditingController descController = new TextEditingController();



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
 
      appBar: AppBar(
        title: Text('Добавление задачи'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
            child: Form(
              key: formKey,
              child: Column(children: [
                _buildTitleTextField(),

                SizedBox(height: 10.0),

                _buildDescriptionsTextField(),

                SizedBox(height: 25.0),

                GestureDetector(
                    onTap: (){
                      if(formKey.currentState.validate()){
                        Provider.of<ApplicationBloc>(context, listen: false).addToDo(titleController.text.trim(), descController.text.trim());
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => App()));
                      }
                    },
                                  child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Center(
                        child: Text(
                        'Добавить',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                  )
              ],),
            )
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