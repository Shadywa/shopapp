import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/bloc/shpo_loging_cubit/shop_cubit.dart';
import 'package:untitled3/bloc/shpo_loging_cubit/shop_state.dart';
import 'package:untitled3/data_layer/cashe_helper.dart';
import 'package:untitled3/shared/componants.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/register.dart';

import '../../../shared/constatas.dart';
import '../layout_page/shop_home.dart';

class Login extends StatelessWidget {
  var emailController=TextEditingController();
  var passController=TextEditingController();
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ShopAppCubit,ShopAppStates>(
        listener: (context, state) {
          if(state is ShopAppSuccess) {
            if(state.loginModel.status){
              print(state.loginModel.message);
              CasheHelper.saveData(key: 'token', value: state.loginModel.data!.token
              ).then((value) {
                token=state.loginModel.data!.token;
                navigatorAndFinish(context: context, widget: const ShopAppHome());
              });


            }else{
              print(state.loginModel.message);
              showToast(text: state.loginModel.message, state: ToastStates.ERROR);


            }
          }
        },
        builder: (context, state) {
          ShopAppCubit cubit =ShopAppCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body:Center(
                child:  SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Login',style: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 35),),
                          const SizedBox(height: 10,),
                          Text('login to join us and browser our offers',style: Theme.of(context).textTheme.labelMedium!.copyWith(fontSize: 14),),

                          const SizedBox(height: 24,),
                          TextFormField(
                            controller: emailController,
                            validator: (value){
                              if(value!.isEmpty){
                                return('filed can not be empty');
                              }
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'email',
                                prefixIcon: Icon(Icons.email)
                            ),

                          ),
                          const SizedBox(height: 10,),
                            TextFormField(
                              // onFieldSubmitted: (value) {
                              //   if (formKey.currentState!.validate()) {
                              //     ShopAppCubit.get(context).logIn(
                              //         email: emailController.text,
                              //         password: passController.text);
                              //   }
                              // },
                              controller: passController,
                              obscureText: cubit.isPassword,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ('filed can not be empty');
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'password',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon:IconButton(onPressed: (){
                                  cubit.passwordProcessTogel();
                                },
                                  icon: Icon(cubit.prefIcon),
                                )
                              ),
                            ),
                            const SizedBox(height: 20,),

                          MaterialButton(
                            height: 50,
                            color: Colors.blue,
                            onPressed: () {
                              if(formKey.currentState!.validate()){
                                ShopAppCubit.get(context).logIn(
                                    email: emailController.text,
                                    password: passController.text);
                              }
                              token==cubit.loginModel.data!.token;
                              },
                            child: Center(
                                child: Text(
                                  'LogIn',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(fontSize: 24, color: Colors.white),
                                )),
                          ),
                          Row(
                            children: [
                              const Text(' Don\'t have email ?'),
                              TextButton(
                                  onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                                  },
                                  child: const Text('click here'))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
          );
        }



    );
  }
}
