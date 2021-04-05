import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/src/bloc/application_bloc.dart';

class ChangeUserData extends StatefulWidget {

  final String firstName;
  final String lastName;
  ChangeUserData({this.firstName, this.lastName});

  @override
  _ChangeUserDataState createState() => _ChangeUserDataState();
}

class _ChangeUserDataState extends State<ChangeUserData> {
  TextEditingController lastNameController = new TextEditingController();

  TextEditingController firstNameController = new TextEditingController();

  @override
  void initState() { 
    super.initState();
    lastNameController.text = widget.lastName;
    firstNameController.text = widget.firstName;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Редактор профиля'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),

        child: SingleChildScrollView(
          child: _userChangeData()
          
        ),
      )
    );
  

  
  }

      Widget _userChangeData(){
  final formKey = GlobalKey<FormState>();
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80.0),

              Text(
                'Профиль',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 65.0),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                                      child: Column(
                      children: <Widget>[
                        _buildFirstNameField(),
                        SizedBox(height: 20.0,),
                        _buildLastNameTextField()
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Consumer<ApplicationBloc>(
                builder: (context, appBloc, child){
                  
                  return GestureDetector(
                    onTap: (){
                      if(formKey.currentState.validate()){
                        appBloc.changeUserData(firstNameController.text.trim(), lastNameController.text.trim());
                        Navigator.of(context).pop();
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
                        'Применить',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                  );
                },),
              SizedBox(height: 10.0),
              //_errorNotify != null ? Center(child: Text(_errorNotify, style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),),) : Container(),
              Divider(height: 10.0),
              
            ],
        );
  }

  Widget _buildLastNameTextField() {
    return TextFormField(
        controller: lastNameController,
            
        validator: (val) {
          return val.length > 1 ? null : 'Введите вашу фамилию!';
        },
        decoration: InputDecoration(
            
            hintText: 'Ваше фамилия',
            hintStyle: TextStyle(color: Colors.grey[700], fontSize: 18.0),
        )
      );
  }

  Widget _buildFirstNameField() {
    return TextFormField(
        controller: firstNameController,
            
        validator: (val) {
          return val.length > 1 ? null : 'Введите ваше имя!';
        },
        decoration: InputDecoration(
            
            hintText: 'Ваше имя',
            hintStyle: TextStyle(color: Colors.grey[700], fontSize: 18.0),

            
              ),

      );
  }
}