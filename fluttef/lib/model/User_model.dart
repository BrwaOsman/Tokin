// ignore_for_file: file_names, camel_case_types

class User_model {
 String? id;
  String? token;
  String? email;


  User_model({this.id, this.token, this.email});

 factory User_model.fromMap(json){
    return User_model(
      id: json['id'],
      token: json['token'],
      email: json['email'],
    );
  }
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["token"] = token;
    map["email"] = email;
    return map;
  }


  
}