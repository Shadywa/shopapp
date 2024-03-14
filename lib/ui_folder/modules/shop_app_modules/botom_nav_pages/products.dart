import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_cubit.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_states.dart';
import 'package:untitled3/data_layer/shop_models/category.dart';
import 'package:untitled3/data_layer/shop_models/home_page_model.dart';
import 'package:untitled3/shared/componants.dart';

class ShopHome extends StatelessWidget {
  const ShopHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener:(context, state) {
        if (state is ShopSuccessChangeFavoritesStates) {
          if (!state.model.status!) {
            showToast(
                text: state.model.message!,
                state: ToastStates.ERROR);
          }
        }
      },
      builder:((context, state) {
        HomeLayoutCubit cubit=HomeLayoutCubit.get(context);

        return ConditionalBuilder(
          condition: cubit.homeModel!=null&&cubit.categoriesModel!=null,
          builder: (context)=>shopHomePage(cubit.homeModel!,cubit.categoriesModel!,context),
          fallback: (context)=>const Center(child:  CircularProgressIndicator()),
        );
      }) ,
    );
  }
  
  
  Widget shopHomePage(HomeModel model,CategoriesModel Catmodel,context){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          shopHomeCondBuilder(model),
          const SizedBox(height: 25),
          const Text('Categories',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,)),
          shopHomeListView(Catmodel),
          const SizedBox(height: 25),
          const Text('Products',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 16,)),
           GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1 / 1.5,
          children: List.generate(
            model.data!.products!.length,
                (index) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Image(
                      image:
                      NetworkImage('${model.data!.products![index].image}'),
                      width: double.infinity,
                      height: 160,
                    ),
                    if (model.data!.products![index].discount != 0)
                      Container(
                        color: Colors.red,
                        height: 15,
                        width: 60,
                        child: const Center(
                            child: Text(
                              'Discount',
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${model.data!.products![index].name}',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text(
                      '${model.data!.products![index].price}',
                      style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    if (model.data!.products![index].discount != 0)
                      Text(
                        '${model.data!.products![index].oldPrice}',
                        style: const TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      backgroundColor: HomeLayoutCubit.get(context).favorite[model.data!.products![index].id!]!?
                      Colors.red:
                      Colors.grey,
                      child: IconButton(
                        onPressed: () {
                          HomeLayoutCubit.get(context).changeFavorites(model.data!.products![index].id!);
                          print(model.data!.products![index].id!);
                        },
                        icon:
                        Icon(
                          Icons.favorite,
                          color: Colors.white,
                            // HomeLayoutCubit.get(context).favorite[model.data!.products![index].id]!=false?
                            // Colors.red:
                        )

                      ),
                    )],
                )
              ],
            ),)
      )
        ],
      ),
    );
  } 
  

  Widget shopHomeCondBuilder(HomeModel model){
    return Container(
      height: 200,
      width: double.infinity,
      child: CarouselSlider(
          items:model.data!.banners!.map((e) =>
              Image(fit: BoxFit.cover,
              image: NetworkImage('${e.image}'))
          ).toList(),
          options: CarouselOptions(
            autoPlayAnimationDuration:const Duration(milliseconds: 800) ,
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: true,
            autoPlay: true,

          ),
      ),
    );
  }

  Widget shopHomeListView(CategoriesModel model){
    return Container(
      height: 150,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder:(context, index)=>Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
              image:NetworkImage('${model.data!.data![index].image}'),
              height: 170,
              width:90,
            ),
            Container(
              width: 85,
              height: 19,
              color: Colors.black.withOpacity(0.5),
              child: Text('${model.data!.data![index].name}',textAlign: TextAlign.center,),
            )
          ],
        ),
        separatorBuilder:(context, index) => const SizedBox(width: 10),
        itemCount:model.data!.data!.length ,
      ),
    );
  }



}