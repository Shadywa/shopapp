import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_cubit.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_states.dart';

import '../../../../shared/componants.dart';

class FavoritesScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>
      (
      listener: (context,state){},
      builder:(context,state)=>
          ConditionalBuilder(
            condition:state is FavoriteSuccessState,
            builder:(context)=> ListView.separated(
                itemBuilder:(context,index)=>buildListProduct(HomeLayoutCubit.get(context).favoritesModel!.data.data[index].product,context),
                separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                itemCount:HomeLayoutCubit.get(context).favoritesModel!.data.data.length),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          ),
    );
  }

}