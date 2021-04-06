import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_with_firebase/helpers/helperfunctions.dart';
enum authProblems { UserNotFound, PasswordNotValid, NetworkError }
class AuthService{
  
CollectionReference users = FirebaseFirestore.instance.collection('users');
FirebaseAuth _auth = FirebaseAuth.instance;


  //Sign Up user to Firebase Auth
  Future signUpUser(String email, String password, String firstName, String lastName) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      users.add({
          'email': email,
          'firstName': firstName, 
          'lastName': lastName 
         }).then((value) => print('success'));

         HelperFunctions.saveUserFirstNameSharedPreference(firstName);
         HelperFunctions.saveUserLastNameSharedPreference(lastName);
         HelperFunctions.saveUserEmailSharedPreference(email);
         HelperFunctions.saveUserLoggedSharedPreference(true);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }



   //Sign In user to Firebase Auth
  Future signInUser(String email, String password) async {
    
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
      ).then((value) async {
        await users
          .where("email", isEqualTo: email)
          .get().then((value) {
            value.docs.forEach((element) {
              HelperFunctions.saveUserFirstNameSharedPreference(element['firstName']);
              HelperFunctions.saveUserLastNameSharedPreference(element['lastName']);
              HelperFunctions.saveUserEmailSharedPreference(element['email']);
              HelperFunctions.saveUserLoggedSharedPreference(true);
            });
            print(email);
            
          });
      });
    return true;
      
    } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          return false;
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          return false;
        }
      }catch(e){
          print(e);
          return false;
      }
  }


   //Sign Out user 
  Future signOut() async {
    try {
      await _auth.signOut();
      HelperFunctions.rmUserFirstNameSharedPreference();
      HelperFunctions.rmUserLastNameSharedPreference();
      HelperFunctions.rmUserEmailSharedPreference();
      HelperFunctions.rmUserLoggedSharedPreference();
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }


  //Change user data!
  Future changeUserData(String firstName, String lastName) async{
    try{
      String email = await HelperFunctions.getUserEmailSharedPreference();
      await users.where("email", isEqualTo: email).get().then((value) async {
        await users.doc(value.docs.last.id).update(
          {
            'firstName': firstName,
            'lastName': lastName
          }
        ).then((value) async {
          await HelperFunctions.saveUserFirstNameSharedPreference(firstName);
          await HelperFunctions.saveUserLastNameSharedPreference(lastName);
          
        });
        
      });
      return true;
    }catch(e){
      print(e.toString());
      return false;
    }
  }


  //Change user only password!
  Future changeUserPassword(String oldPassword, String newPassword) async {
    try{
      String email = await HelperFunctions.getUserEmailSharedPreference();
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: oldPassword
      ).then((value) {
        value.user.updatePassword(newPassword);
      });
      return true;

    }on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          return false;
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          return false;
        }
      }catch(e){
        print(e.toString());
        return false;
    }
  }
}
