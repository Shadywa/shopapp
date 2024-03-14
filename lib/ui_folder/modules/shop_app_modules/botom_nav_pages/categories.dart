import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_cubit.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_states.dart';
import 'package:untitled3/data_layer/shop_models/category.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context, state) {},
      builder: ((context, state) {
        HomeLayoutCubit cubit=HomeLayoutCubit.get(context);
        return ConditionalBuilder(
            condition: (cubit.categoriesModel!=null),
            builder:(context)=>  ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: ( context,index)=>BuildListViewItem(cubit.categoriesModel!.data!.data![index],context),
              separatorBuilder: (context, index) => Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
              itemCount:cubit.categoriesModel!.data!.data!.length,
            ),
            fallback: (context)=>const Center(child: CircularProgressIndicator(),));
      }),
       );
  }

  Widget BuildListViewItem(dataInData model, context) => InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: 135,
              height: 140,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              '${model.name}',
              style: Theme.of(context).textTheme.bodyText1,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
          ],
        ),
      );
}