import 'package:untitled3/data_layer/shop_models/user_model.dart';

import '../../data_layer/shop_models/change_favorite.dart';
import '../../data_layer/shop_models/profile_model.dart';

abstract class HomeLayoutStates{}

class HomeLayoutInitState extends HomeLayoutStates{}
class HomeLayoutNAVBARState extends HomeLayoutStates{}
class HomeLoadingState extends HomeLayoutStates{}
class HomeSuccessState extends HomeLayoutStates{}
class HomeErrorState extends HomeLayoutStates{}
class CategorySuccessState extends HomeLayoutStates{}
class CategoryErrorState extends HomeLayoutStates{}
class FavoriteSuccessState extends HomeLayoutStates{}
class FavoriteErrorState extends HomeLayoutStates{}
class FavoriteLoadingState extends HomeLayoutStates{}
class ShopChangeFavoritesStates extends HomeLayoutStates{}

class ShopSuccessChangeFavoritesStates extends HomeLayoutStates
{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesStates(this.model);
}
class ShopErrorChangeFavoritesStates extends HomeLayoutStates{}

class SettingLoadingState extends HomeLayoutStates{}
class SettingSuccessState extends HomeLayoutStates{
  final LoginModel loginModel;

  SettingSuccessState(this.loginModel);
}
class SettingErrorState extends HomeLayoutStates{}

class ShopLoadingUserDataStates extends HomeLayoutStates{}
class ShopSuccessUserDataStates extends HomeLayoutStates
{
  final LoginModel loginModel;

  ShopSuccessUserDataStates(this.loginModel);
}class ShopErrorUserDataStates extends HomeLayoutStates{}

class ShopLoadingUpdateUserStates extends HomeLayoutStates{}

class ShopSuccessUpdateUserStates extends HomeLayoutStates
{
  final LoginModel  loginModel;

  ShopSuccessUpdateUserStates(this.loginModel);
}
class ShopErrorUpdateUserStates extends HomeLayoutStates{}
