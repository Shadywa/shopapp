import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_cubit.dart';
import 'package:untitled3/bloc/shpo_loging_cubit/shop_state.dart';
import 'package:untitled3/shared/themes.dart';
import 'package:untitled3/ui_folder/modules/layout_page/shop_home.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/shop_app_on_boarding.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/login.dart';
import 'bloc/shpo_loging_cubit/shop_cubit.dart';
import 'data_layer/cashe_helper.dart';
import 'data_layer/remotly_data.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  DioHelper.init();
  await CasheHelper.init();
  String? token=CasheHelper.getAllFromShared(key: 'token');
  bool? isDark=CasheHelper.getAllFromShared(key: 'isDark');
  bool? onBoarding=CasheHelper.getAllFromShared(key: 'onBoarding');
  print(token);
  Widget widget;

  if(onBoarding !=null){
    if(token !=null){
      widget = const ShopAppHome();
    }else
      widget =Login();


  }else widget =OnBoardingScreen();
  Widget startWidget =widget;


     //علشان مشكلة ال ( null check operator used on null value)null safety
  // is dark هنا ممكن تكون null ف مينفعش ادي علامة تعجب ل ماي اب
  //بدلتها ب اتنين علامة استفهام علشان لو مش موجوده يرجع false

  runApp( MyApp(isDark!,startWidget));

}

class MyApp extends StatelessWidget {

  final bool isDark;
  final Widget startWidget;

  MyApp(this.isDark,this.startWidget, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:[
        BlocProvider(
        create: (BuildContext context)=>ShopAppCubit(),),
          BlocProvider(
              create: (BuildContext context)=>HomeLayoutCubit()..getHomeData()..getCategoryData()..getFavourites()..userModelData()
          ),
        ],
       child: BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context, state) {},
      builder: ((context, state) {
        ShopAppCubit cubit=BlocProvider.of(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,

          darkTheme: darkMode,

          themeMode: ThemeMode.light,

          home: ShopAppHome(),
        );
      }),
    ),

    );

  }
}

