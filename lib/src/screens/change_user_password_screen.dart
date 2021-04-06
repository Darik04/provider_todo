import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/src/bloc/application_bloc.dart';

class ChangeUserPassword extends StatefulWidget {

  @override
  _ChangeUserPasswordState createState() => _ChangeUserPasswordState();
}

class _ChangeUserPasswordState extends State<ChangeUserPassword> {

  //Text editing controllers for change password
  TextEditingController oldPasswordController = new TextEditingController();
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController passwordConfirmController = new TextEditingController();


  //Hide password fields
  bool _toggleVisibility = true;
  bool _toggleNewVisibility = true;
  bool _toggleConfirmVisibility = true;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  showSnackBar(String message){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Редактор пароля'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),

        child: SingleChildScrollView(
          child: _userChangePassword()
          
        ),
      )
    );
  

  
  }

      Widget _userChangePassword(){
  final formKey = GlobalKey<FormState>();
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 80.0),

              Text(
                'Пароль',
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
                        _buildOldPasswordTextField(),
                        SizedBox(height: 20.0),
                        _buildNewPasswordTextField(),
                        SizedBox(height: 20.0),
                        _buildPasswordConfirmTextField()
                        
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              GestureDetector(
                    onTap: (){
                      if(formKey.currentState.validate()){
                        if(newPasswordController.text.trim() == passwordConfirmController.text.trim()){
                          Provider.of<ApplicationBloc>(context, listen: false).changeUserPasswrod(oldPasswordController.text.trim(), newPasswordController.text.trim());
                          
                        }else{
                          showSnackBar('Введеные пароли не совпадают!');
                        }
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
                ),
                
              SizedBox(height: 10.0),
              
              //_errorNotify != null ? Center(child: Text(_errorNotify, style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),),) : Container(),
              Divider(height: 10.0),
              Consumer<ApplicationBloc>(
                      builder: (context, appBloc, child){
                        switch(appBloc.userChangePasswordState){
                          case userChangePasswordEnum.isDefault:
                            return Container();
                          case userChangePasswordEnum.isLoading:
                            return Center(child: CircularProgressIndicator(),);
                            break;
                          case userChangePasswordEnum.isError:
                            return Center(child: Text('Не верный пароль!', style: TextStyle(fontSize: 18.0, color: Colors.red[800])),);
                            break;
                          case userChangePasswordEnum.isSuccess:
                            return Center(child: Text('Пароль успешно изменен!', style: TextStyle(fontSize: 18.0, color: Colors.green[800])),);
                            break;
                        }
                      }
                    ),
            ],
        );
  }


Widget _buildOldPasswordTextField() {
    return TextFormField(
        controller: oldPasswordController,
            
        validator: (val) {
          return val.length > 5 ? null : 'Пароль не должен быть меньше 5 символов';
        },
        decoration: InputDecoration(
            
            hintText: 'Ваш текущий пароль',
            hintStyle: TextStyle(color: Colors.grey[700], fontSize: 18.0),

            suffixIcon:
                IconButton(
                  onPressed: () {
                    setState(() {
                      _toggleVisibility = !_toggleVisibility;
                    });
                  }, 
                  icon: _toggleVisibility ? Icon(Icons.visibility_off) : Icon(Icons.visibility) 
                  )
              ),
        obscureText: _toggleVisibility,
      );
  }
 Widget _buildNewPasswordTextField() {
    return TextFormField(
        controller: newPasswordController,
            
        validator: (val) {
          return val.length > 5 ? null : 'Пароль не должен быть меньше 5 символов';
        },
        decoration: InputDecoration(
            
            hintText: 'Ваш новый пароль',
            hintStyle: TextStyle(color: Colors.grey[700], fontSize: 18.0),

            suffixIcon:
                IconButton(
                  onPressed: () {
                    setState(() {
                      _toggleNewVisibility = !_toggleNewVisibility;
                    });
                  }, 
                  icon: _toggleNewVisibility ? Icon(Icons.visibility_off) : Icon(Icons.visibility) 
                  )
              ),
        obscureText: _toggleNewVisibility,
      );
  }


  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
        controller: passwordConfirmController,
            
        validator: (val) {
          return val.length > 5 ? null : 'Пароль не должен быть меньше 5 символов';
        },
        decoration: InputDecoration(
            
            hintText: 'Повторите пароль',
            hintStyle: TextStyle(color: Colors.grey[700], fontSize: 18.0),

            suffixIcon:
                IconButton(
                  onPressed: () {
                    setState(() {
                      _toggleConfirmVisibility = !_toggleConfirmVisibility;
                    });
                  }, 
                  icon: _toggleConfirmVisibility ? Icon(Icons.visibility_off) : Icon(Icons.visibility) 
                  )
              ),
        obscureText: _toggleConfirmVisibility,
      );
  }
}