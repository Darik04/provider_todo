import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/src/app.dart';
import 'package:todo_with_firebase/src/bloc/application_bloc.dart';
import 'package:todo_with_firebase/src/screens/signin_screen.dart';

class SignUpScreen extends StatefulWidget {

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 
  //Sign Up
  TextEditingController emailSignUpController = new TextEditingController();
  TextEditingController lastNameController = new TextEditingController();
  TextEditingController firstNameController = new TextEditingController();
  TextEditingController passwordSignUpController = new TextEditingController();
  TextEditingController passwordSignUpConfirmController = new TextEditingController();

  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _toggleVisibility = true;
  bool _toggleConfirmVisibility = true;

  showSnackBar(String message){
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message),));
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),

        child: SingleChildScrollView(
          child: _signUp()
          
        ),
      )
    );
  }

  
Widget _signUp(){
  final formKeySignUp = GlobalKey<FormState>();
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 60.0),

              Text(
                'Регистрация',
                style: TextStyle(fontSize: 35.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 35.0),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     Text(
              //       'Забыли пароль?',
              //       style: TextStyle(
              //           fontSize: 16.0,
              //           color: Theme.of(context).primaryColor,
              //           fontWeight: FontWeight.bold),
              //     )
              //   ],
              // ),
              SizedBox(height: 10.0),
              Card(
                elevation: 5.0,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKeySignUp,
                                      child: Column(
                      children: <Widget>[
                        _buildFirstNameField(),
                        SizedBox(height: 20.0),
                        _buildLastNameTextField(),
                        SizedBox(height: 20.0),
                        _buildSignUpEmailTextField(),
                        SizedBox(height: 20.0),
                        _buildSignUpPasswordTextField(),
                        SizedBox(height: 20.0),
                        _buildPasswordConfirmTextField()
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Consumer<ApplicationBloc>(
                builder: (context, appBloc, child){
                  
                  return GestureDetector(
                    onTap: () async {
                      if(formKeySignUp.currentState.validate()){
                        if(passwordSignUpController.text.trim() == passwordSignUpConfirmController.text.trim()){
                          bool success = await appBloc.signUp(emailSignUpController.text.trim(), passwordSignUpController.text.trim(), firstNameController.text.trim(), lastNameController.text.trim());
                          if(success){
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => App()));
                          }
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
                        'Зарегенится',
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
              Consumer<ApplicationBloc>(
                builder: (context, appBloc, child){
                        switch(appBloc.signUpState){
                          case signUpEnum.isDefault:
                            return Container();
                          case signUpEnum.isLoading:
                            return Center(child: CircularProgressIndicator(),);
                            break;
                          case signUpEnum.isError:
                            return Center(child: Text('Пользователь с таким email-ом уже есть!'),);
                            break;
                        }
                }
              ),
              //_errorNotify != null ? Center(child: Text(_errorNotify, style: TextStyle(color: Colors.red, fontSize: 20.0, fontWeight: FontWeight.bold),),) : Container(),
              Divider(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Уже бывали?',
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  SizedBox(
                    width: 10.0,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SignInScreen()));
                    },
                                  child: Text(
                      'войти',
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

  Widget _buildSignUpEmailTextField() {
    return TextFormField(
        controller: emailSignUpController,
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

  Widget _buildSignUpPasswordTextField() {
    return TextFormField(
        controller: passwordSignUpController,
            
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
  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
        controller: passwordSignUpConfirmController,
            
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