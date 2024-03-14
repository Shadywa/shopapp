import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/shpo_loging_cubit/shop_state.dart';
import 'package:untitled3/data_layer/remotly_data.dart';
import 'package:untitled3/data_layer/shop_models/user_model.dart';
import 'package:untitled3/shared/end_points.dart';

class ShopAppCubit extends Cubit<ShopAppStates>{
  late LoginModel  loginModel;
  ShopAppCubit():super(ShopAppInitial());
  static ShopAppCubit get(context)=>BlocProvider.of(context);



  void logIn({
    required String email,
    required String password,
  }) {
    emit(ShopAppLoading());
    DioHelper.PostData(url: loginUrl, data: {
      'email': email,
      'password': password,
    }).then((value) {
     loginModel=LoginModel.fromJason(value.data);
     emit(ShopAppSuccess(loginModel));
    }).catchError((error) {
      emit(ShopAppError(error.toString()));
      print(error.toString());
    });
  }

  bool isPassword =true;
  IconData prefIcon=Icons.visibility_outlined;
  void passwordProcessTogel(){
   if(isPassword){
     prefIcon=Icons.visibility_off_outlined;
     isPassword=!isPassword;
   }else{
     prefIcon=Icons.visibility_outlined;
     isPassword=!isPassword;
   }
   emit(LogingPassword());
  }
}