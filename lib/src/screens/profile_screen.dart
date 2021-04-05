
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_with_firebase/src/app.dart';
import 'package:todo_with_firebase/src/bloc/application_bloc.dart';
import 'package:todo_with_firebase/src/screens/change_user_data_screen.dart';
import 'package:todo_with_firebase/src/screens/change_user_password_screen.dart';

class ProfileScreen extends StatelessWidget {
final listTextStyle = TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600);
final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

  void confirm(){
    AlertDialog alertDialog = AlertDialog(
      content: Text('Вы точно хотите выйти!'),
      actions: <Widget>[
        RaisedButton(
          child: Text('Выйти', style: TextStyle(color: Colors.white),),
          color: Colors.red,
          onPressed: (){
            Navigator.pop(context);
            Provider.of<ApplicationBloc>(context, listen: false).signOut();
            Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => App()));
          },
        ),
        RaisedButton(
          child: Text('Отмена', style: TextStyle(color: Colors.white),),
          color: Colors.green,
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(context: _scaffoldKey.currentContext, builder: (context) => alertDialog);
  }


    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 10.0),
        child: Consumer<ApplicationBloc>(
          builder: (context, appBloc, child){
            switch(appBloc.userLogged){
              case userLoggedEnum.isLogged:
                return ListView(
          children: [
            Material(
                  color: Theme.of(context).cardColor,
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            Icon(Icons.person, size: 30.0,),
                            SizedBox(width:15.0),
                            Text(
                              
                                    appBloc.userModel.firstName + ' ' + appBloc.userModel.lastName,
                                    style: TextStyle(
                                        fontSize: 18.0, fontWeight: FontWeight.w600),
                                  ),
                          ],
                        ),
                        SizedBox(height: 15.0),
                        Row(
                          children: <Widget>[
                            Icon(Icons.mail_outline, size: 30.0,),
                            SizedBox(width:15.0),
                            Text(
                              
                                    appBloc.userModel.email,
                                    style: TextStyle(
                                        fontSize: 18.0, fontWeight: FontWeight.w600),
                                  ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

            SizedBox(height: 25.0),


            Material(
                  color: Theme.of(context).cardColor,
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Редактировать профиль',
                                  style: listTextStyle),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChangeUserData(firstName: appBloc.userModel.firstName, lastName: appBloc.userModel.lastName)));
                                  },
                                  child: Icon(
                                    Icons.create_outlined,
                                    size: 30.0,
                                  )),
                            ],
                          )
                  ),
                ),
                SizedBox(height: 10.0),
            Material(
                  color: Theme.of(context).cardColor,
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Изменить пароль',
                                  style: listTextStyle),
                              GestureDetector(
                                  onTap: (){
                                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ChangeUserPassword()));
                                  },
                                  child: Icon(
                                    Icons.create_outlined,
                                    size: 30.0,
                                  )),
                            ],
                          )
                  ),
                ),

                SizedBox(height: 50.0),

                GestureDetector(
                  onTap: (){
                  
                    confirm();
                  },
                  child: Center(child: Text('Выйти!', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),))
                )
          ]
        );
          break;
        default:
          return Container();
            }
            
          },
        )
      ),
    );






    
  }




  
}