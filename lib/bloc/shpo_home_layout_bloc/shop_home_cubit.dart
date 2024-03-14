import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_states.dart';
import 'package:untitled3/data_layer/cashe_helper.dart';
import 'package:untitled3/data_layer/remotly_data.dart';
import 'package:untitled3/data_layer/shop_models/category.dart';
import 'package:untitled3/data_layer/shop_models/home_page_model.dart';
import 'package:untitled3/data_layer/shop_models/user_model.dart';
import 'package:untitled3/shared/constatas.dart';
import 'package:untitled3/shared/end_points.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/botom_nav_pages/categories.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/botom_nav_pages/favourites.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/botom_nav_pages/nav_seeting.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/botom_nav_pages/products.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/login.dart';

import '../../data_layer/shop_models/change_favorite.dart';
import '../../data_layer/shop_models/favorite.dart';
import '../../data_layer/shop_models/profile_model.dart';

class  HomeLayoutCubit extends Cubit<HomeLayoutStates>{

  HomeLayoutCubit():super(HomeLayoutInitState());

  static HomeLayoutCubit  get(context)=>BlocProvider.of(context);



  List<Widget> navScreen=[
    const ShopHome(),
    const Categories(),
    FavoritesScreen(),
    SettingScreen()
  ];

  var currentIndex=0;
  void BNBar(index){
    currentIndex=index;
    emit(HomeLayoutNAVBARState());
  }

   HomeModel? homeModel;
  Map<int,bool>favorite={};
  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getAllData(
      url: shopHomePoint,
      token: token,
    ).then((value){
      homeModel =HomeModel.fromJason(value.data);
      homeModel?.data!.products!.forEach((element) {
        favorite.addAll({
          element.id!:element.inFavorites!
        });
      });
      print(favorite);
      emit(HomeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(HomeErrorState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategoryData(){
    DioHelper.getAllData(
      url: CATEGORY,
      token: token,
    ).then((value){
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(CategorySuccessState());
    }).catchError((error){
      emit(CategoryErrorState());
      print(error.toString());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorite[productId]=!favorite[productId]!;
    emit(ShopChangeFavoritesStates());
    DioHelper.PostData(
      url: FAVORITE,
      data: {
        'product_id':productId,
      },
      token: token

    ).
    then((value)
    {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      emit(ShopSuccessChangeFavoritesStates(changeFavoritesModel!));
      {
        getFavourites();
      } // if(!changeFavoritesModel!.status!)
      // {
      //   favorite[productId]=!favorite[productId]!;
      //
      // }else

    }
    ).catchError((error)
    {
      favorite[productId]=!favorite[productId]!;

      emit(FavoriteErrorState());
    });
  }


  FavoritesModel?favoritesModel;
  void getFavourites() {

    emit(FavoriteLoadingState());
    DioHelper.getAllData(
      url: FAVORITE,
      token: token,
    ).
    then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);

      emit(FavoriteSuccessState());
    }
    ).
    catchError((error) {
      print(error.toString());
      emit(FavoriteErrorState());
    }
    );
  }


  LoginModel?userModel;
  void userModelData() {

    emit(ShopLoadingUserDataStates());
    DioHelper.getAllData(
      url: PROFILE,
      token: token,
    ).
    then((value) {
      userModel=LoginModel.fromJason(value.data);
      print(userModel!.data!.name);
      emit(ShopSuccessUserDataStates(userModel!));
    }
    ).
    catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataStates());
    }
    );
  }

  void signOut(context){
CasheHelper.removeData(key: 'token').then((value){
  if(value){
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
  }
});
  }
  void updateUserData({
    required String name,
    required String email,
    required String phone
  }) {

    emit(ShopLoadingUpdateUserStates());
    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data:
        {
          'name':name,
          'email':email,
          'phone':phone,

        }
    ).
    then((value) {
      userModel=LoginModel.fromJason(value.data);

      emit(ShopSuccessUpdateUserStates(userModel!));
    }
    ).
    catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserStates());
    }
    );
  }



}