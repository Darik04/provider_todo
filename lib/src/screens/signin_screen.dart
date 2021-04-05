import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/src/bloc/application_bloc.dart';
import 'package:todo_with_firebase/src/screens/signup_screen.dart';

class SignInScreen extends StatefulWidget {

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  
  //Sign In
  TextEditingController emailSignInController = new TextEditingController();
  TextEditingController passwordSignInController = new TextEditingController();
  

  bool _toggleVisibility = true;

 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: _signIn(),
          
        ),
      )
    );
  }

  
  Widget _signIn(){
    final formKeySignIn = GlobalKey<FormState>();
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 115.0),

              Text(
                'Вход',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 90.0),
            
              SizedBox(height: 10.0),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKeySignIn,
                                      child: Column(
                      children: <Widget>[
                        
                        _buildSignInEmailTextField(),
                        SizedBox(height: 20.0),
                        _buildSignInPasswordTextField()
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              
                      GestureDetector(
                        onTap: (){
                          if(formKeySignIn.currentState.validate()){
                            Provider.of<ApplicationBloc>(context, listen: false).signIn(emailSignInController.text.trim(), passwordSignInController.text.trim());
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
                            'Войти',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                      ),
                      SizedBox(height: 15.0),
                      
                    Consumer<ApplicationBloc>(
                      builder: (context, appBloc, child){
                        switch(appBloc.signInState){
                          case signInEnum.isDefault:
                            return Container();
                          case signInEnum.isLoading:
                            return Center(child: CircularProgressIndicator(),);
                            break;
                          case signInEnum.isError:
                            return Center(child: Text('Не верный пароль или email!'),);
                            break;
                        }
                      }
                    ),

             
                    
                  
              SizedBox(height: 5.0),
              SizedBox(height: 5.0),
              //_errorNotify != null ? Center(child: Text(_errorNotify, style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),),) : Container(),
              Divider(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Первый раз?',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: (){
                     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignUpScreen()));
                    },
                                  child: Text(
                      'Зарегистрируйтесь',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  SizedBox(height: 80.0),

                ],
              )
            ],
        );
  }


  Widget _buildSignInEmailTextField() {
    return TextFormField(
        controller: emailSignInController,
        validator: (val) {
                          return RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val)
                              ? null
                              : "Не корректный e-mail";
                        },
        decoration: InputDecoration(
          hintText: 'Ваш email',
          hintStyle: TextStyle(color: Colors.grey[700], fontSize: 18.0),
        ),
      );
  }

  Widget _buildSignInPasswordTextField() {
    return TextFormField(
        controller: passwordSignInController,
            
        validator: (val) {
          return val.length > 5 ? null : 'Пароль не должен быть меньше 5 символов';
        },
        decoration: InputDecoration(
            
            hintText: 'Ваш пароль',
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


}