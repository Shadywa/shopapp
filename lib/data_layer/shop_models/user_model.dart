import 'package:flutter/cupertino.dart';

class LoginModel {
  late bool status;
  late String message;
  UserLogin? data ;

  LoginModel.fromJason(Map<String,dynamic>json){
    status =json['status'];
    message =json['message'];
    data =json['data'] !=null ?UserLogin.fromJason(json['data']):null ;

  }

}
class UserLogin {
   int? id;
   String? name;
   String? email;
   String? phone;
   String? image;
   int? point;
   int? credit;
   String? token;


  UserLogin.fromJason(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    point = json['point'];
    credit = json['credit'];
    token = json['token'];

  }

}