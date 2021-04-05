
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/helpers/helperfunctions.dart';
import 'package:todo_with_firebase/src/models/todo.dart';
import 'package:todo_with_firebase/src/models/user.dart';
import 'package:todo_with_firebase/src/services/auth_service.dart';
import 'package:todo_with_firebase/src/services/todo_service.dart';


enum listTodoStateEnum{
    isEmpty,
    isLoading,
    isNotEmprty
  }

enum userLoggedEnum{
    isLoading,
    isLogged,
    isNotLogged,
  }
  enum signInEnum{
    isLoading,
    isDefault,
    isError,
  }
  enum signUpEnum{
    isLoading,
    isDefault,
    isError
  }
class ApplicationBloc with ChangeNotifier{

  AuthService authService = new AuthService();
  TodoService todoService = new TodoService();
  UserModel userModel;

  List<Todo> _todos;
  get todos => this._todos;
  var _listTodoState;
  get listTodoState => this._listTodoState;

  ApplicationBloc(){
    _userLogged = userLoggedEnum.isLoading;
    checkLoggedUser();
    
  }

  var _userLogged;
  get userLogged => this._userLogged;

  var _signInState = signInEnum.isDefault;
  get signInState => this._signInState;

  var _signUpState = signUpEnum.isDefault;
  get signUpState => this._signUpState;

  checkLoggedUser() async {
    String email = await HelperFunctions.getUserEmailSharedPreference();
    String firstName = await HelperFunctions.getUserFirstNameSharedPreference();
    String lastName = await HelperFunctions.getUserLastNameSharedPreference();
    bool isLogged = await HelperFunctions.getUserLoggedSharedPreference();

    userModel = UserModel(email: email, firstName: firstName, lastName: lastName);
    
    
    if(isLogged != null && isLogged == true) {
      fetchToDo();
      _userLogged = userLoggedEnum.isLogged;
      print('User is Logged');
      notifyListeners();
    }else{
      _userLogged = userLoggedEnum.isNotLogged;
      print('User is NotLogged');
      notifyListeners();
    }
      
    
    

  }

  signIn(String email, String password) async {
    _signInState = signInEnum.isLoading;
    notifyListeners();
    bool isSuccess = await authService.signInUser(email, password);
    if(isSuccess){
      checkLoggedUser();
       _signInState = signInEnum.isDefault;
    }else{
      _signInState = signInEnum.isError;
      notifyListeners();
    }
  }

  signUp(String email, String password, String firstName, String lastName) async {
    bool isSuccess = await authService.signUpUser(email, password, firstName, lastName);
    if(isSuccess){
      checkLoggedUser();
      _signUpState = signUpEnum.isDefault;
    }else{
      _signUpState = signUpState.isError;
      notifyListeners();
    }
  }

  signOut()async{
    bool success = await authService.signOut();
    if(success) checkLoggedUser();
    
    
  }





  //Todo service middle
  
  fetchToDo() async{
    _listTodoState = listTodoStateEnum.isLoading;
    _todos = [];
    notifyListeners();
    
    List<Todo> checkList = await todoService.fetchToDos();
    if(checkList.isEmpty){
      _listTodoState = listTodoStateEnum.isEmpty;
    }else{
      _listTodoState = listTodoStateEnum.isNotEmprty;
      _todos = checkList;
    }
    
    notifyListeners();
  }


  addToDo(String title, String desc) async {
    bool succes = await todoService.addToDo(title, desc);
    if(succes) fetchToDo();
  }

  updateToDo(Todo todo) async {
    bool succes = await todoService.updateToDo(todo);
    if(succes) fetchToDo();
  }
}