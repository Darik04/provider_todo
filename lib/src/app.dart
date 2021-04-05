import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/src/bloc/application_bloc.dart';
import 'package:todo_with_firebase/src/screens/auth_screen.dart';
import 'package:todo_with_firebase/src/screens/main_list_todo_screen.dart';
import 'package:todo_with_firebase/src/screens/signin_screen.dart';

enum AuthState { 
   logged,
   notLogged
}
class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}



class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
          child: MaterialApp(
        title: 'Постановка задач',
        theme: ThemeData(
          primaryColor: Colors.lightBlue[900]
        ),
        debugShowCheckedModeBanner: false,
        home: Consumer<ApplicationBloc>(
          builder: (context, appBloc, child){
            switch(appBloc.userLogged){
              case userLoggedEnum.isLoading:
                  return Scaffold(body: Center(child: CircularProgressIndicator()));
                  break;
              case userLoggedEnum.isNotLogged:
                  return SignInScreen();
                  break;
              case userLoggedEnum.isLogged:
                  return MainListTodoScreen();
                  break;
            }
          },
        )
      ),
    );
  }
}