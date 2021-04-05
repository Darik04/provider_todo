import 'package:shared_preferences/shared_preferences.dart';

// setting data || upload

class HelperFunctions {
  static String sharedPreferenceUserLoggedInKey = 'ISLOGGEDIN';
  static String sharedPreferenceUserFirstNameKey = 'USERFIRSTNAMEKEY';
  static String sharedPreferenceUserLastNameKey = 'USERLASTNAMEKEY';
  static String sharedPreferenceUserEmailKey = 'USEREMAILKEY';

  static Future<bool> saveUserLoggedSharedPreference(
      bool isUserLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(sharedPreferenceUserLoggedInKey, isUserLoggedIn);
  }

  static Future<bool> saveUserFirstNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserFirstNameKey, userName);
  }
  static Future<bool> saveUserLastNameSharedPreference(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserLastNameKey, userName);
  }

  static Future<bool> saveUserEmailSharedPreference(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(sharedPreferenceUserEmailKey, userEmail);
  }

  // getting data

  static Future<bool> getUserLoggedSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getBool(sharedPreferenceUserLoggedInKey);
  }

  static Future<String> getUserFirstNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserFirstNameKey);
  }
  static Future<String> getUserLastNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserLastNameKey);
  }

  static Future<String> getUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(sharedPreferenceUserEmailKey);
  }







  // remove data

  static rmUserLoggedSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(sharedPreferenceUserLoggedInKey);
  }

  static rmUserFirstNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(sharedPreferenceUserFirstNameKey);
  }
  static rmUserLastNameSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(sharedPreferenceUserLastNameKey);
  }

  static rmUserEmailSharedPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(sharedPreferenceUserEmailKey);
  }
}
