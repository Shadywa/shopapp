import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_cubit.dart';
import 'package:untitled3/bloc/shpo_home_layout_bloc/shop_home_states.dart';

// ignore: must_be_immutable
class SettingScreen extends StatelessWidget {
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  var fromKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener:(context,state) {
        if(state is ShopSuccessUserDataStates) {
          nameController.text = state.loginModel.data!.name!;
          emailController.text = state.loginModel.data!.email!;
          phoneController.text = state.loginModel.data!.phone!;

        }
      },
      builder:(context,state) {
        // var model=HomeLayoutCubit.get(context).userModel;
        // nameController.text=model!.data!.name!;
        // emailController.text=model.data!.email!;
        // phoneController.text=model.data!.phone!;
      return  ConditionalBuilder(
          condition: HomeLayoutCubit
              .get(context)
              .userModel != null,
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: fromKey,
                  child: Column(
                    children:
                    [
                      if(state is ShopLoadingUserDataStates)
                        LinearProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),

                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                        decoration: InputDecoration(
                          labelText: "Name",
                          prefixIcon: Icon(
                              Icons.person
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "name must not be empty ";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                        decoration: const InputDecoration(
                          labelText: "Email address",
                          prefixIcon: Icon(
                              Icons.email
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "email address must not be empty ";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (String value) {
                          print(value);
                        },
                        decoration: const InputDecoration(
                          labelText: "Phone",
                          prefixIcon: Icon(
                              Icons.phone
                          ),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "phone must not be empty ";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: MaterialButton(onPressed: () {
                          HomeLayoutCubit.get(context).signOut(context);
                        },
                          child: const Text("LOGOUT",
                            style: TextStyle(
                                color: Colors.white
                            ),),),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.blue,
                        child: MaterialButton(onPressed: () {
                          if(fromKey.currentState!.validate())
                          {
                            HomeLayoutCubit.get(context).updateUserData(
                                name: nameController.text,
                                email:emailController.text ,
                                phone:phoneController.text);
                          }

                        },
                          child: const Text("UPDATE",
                            style: TextStyle(
                                color: Colors.white
                            ),),),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          fallback: (context) =>
          const Center(child: CircularProgressIndicator()),
        );
      });
  }
}
