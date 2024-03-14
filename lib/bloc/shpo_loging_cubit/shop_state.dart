import 'package:untitled3/data_layer/shop_models/user_model.dart';

abstract class ShopAppStates{}

class ShopAppInitial extends ShopAppStates{}

class ShopAppLoading extends ShopAppStates{}

class ShopAppSuccess extends ShopAppStates{
  final LoginModel loginModel;

  ShopAppSuccess(this.loginModel);
}

class ShopAppError extends ShopAppStates{
  final String error;


  ShopAppError(this.error);
}

class LogingPassword extends ShopAppStates{}