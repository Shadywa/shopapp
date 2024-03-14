import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_cubit.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_states.dart';
import 'package:untitled3/shared/componants.dart';

import '../shop_app_modules/search.dart';

class ShopAppHome extends StatelessWidget {
  const ShopAppHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            HomeLayoutCubit cubit = HomeLayoutCubit.get(context);

            return Scaffold(
              appBar: AppBar(
                leading: const Drawer(
                  elevation: 0,
                  child: Icon(
                    Icons.menu,
                    size: 35,
                  ),
                ),
                title: Text(
                  'salla',
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.center,
                ),
                actions:  [
                  Container(
                    width:60,
                    child:  Center(
                     child: IconButton(
                         onPressed: (){
                           navigatorPush(context: context, widget: const Search());
                         },
                         icon: const Icon(
                           Icons.search,
                           size: 35,
                         ),
                      ),
                    )
                  ),

                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: cubit.navScreen[cubit.currentIndex],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.BNBar(index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(CupertinoIcons.home),
                      label: 'home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps),
                      label: 'category'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'favorites'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'settings'),
                ],
              ),
            );
          }
    );
  }
}
