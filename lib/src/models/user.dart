class UserModel{
  final String uID;
  final String firstName;
  final String lastName;
  final String email;

  UserModel({this.uID, this.firstName, this.lastName, this.email});

 factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
        uID:  json['user_id'],
        firstName: json['name'],
        lastName: json['email'],
        email: json['email_verified_at']
    );
  }
}