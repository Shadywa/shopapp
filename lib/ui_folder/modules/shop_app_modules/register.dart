import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled3/shared/componants.dart';
import 'package:untitled3/shared/constatas.dart';
import 'package:untitled3/ui_folder/modules/shop_app_modules/botom_nav_pages/products.dart';


import '../../../bloc/shop_register_cubit/cubit.dart';
import '../../../bloc/shop_register_cubit/states.dart';
import '../../../data_layer/cashe_helper.dart';

// ignore: must_be_immutable
class Register  extends StatelessWidget {

  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var phoneController =TextEditingController();
  var passwordController =TextEditingController();
  var fromKey=GlobalKey<FormState>();
  bool isPassword=true;
  IconData suffix=Icons.visibility_outlined;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ShopRegisterCubit(),

      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener:(context,state)
        {
          if(state is ShopRegisterSuccessState) {
            if (state.registerModel.status!) {
              print(state.registerModel.message);
              print(state.registerModel.message);
              CasheHelper.saveData(
                  key: 'token',
                  value: state.registerModel.data?.token).then((value)
              {
                token=state.registerModel.data!.token;
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const ShopHome()), (route) => false);
              });
            } else {
              showToast(
                text: state.registerModel.message!,
                state: ToastStates.ERROR,
              );
              print(state.registerModel.message);
            }
          }
        },
        builder:(context,state)
        {
          return Scaffold(
            appBar:AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: fromKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REGISTER',
                          style:Theme.of(context).textTheme.headline4?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black
                          )
                          ,),
                        Text('Register now to brows our hot  offers',
                          style:Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold
                          )
                          ,),
                        SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          controller:nameController ,
                          keyboardType:TextInputType.name,
                          onFieldSubmitted: (String value){
                            print(value);
                          },
                          decoration:InputDecoration(
                            labelText:"User Name",
                            prefixIcon: Icon(
                                Icons.person
                            ),
                            border:OutlineInputBorder(),
                          ),
                          validator:(value) {
                            if(value!.isEmpty){
                              return "Name must not be empty ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          controller:emailController ,
                          keyboardType:TextInputType.emailAddress,
                          onFieldSubmitted: (String value){
                            print(value);
                          },
                          decoration:InputDecoration(
                            labelText:"email address",
                            prefixIcon: Icon(
                                Icons.email
                            ),
                            border:OutlineInputBorder(),
                          ),
                          validator:(value) {
                            if(value!.isEmpty){
                              return "Email address must not be empty ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          controller:passwordController ,
                          keyboardType:TextInputType.visiblePassword,
                          obscureText:ShopRegisterCubit.get(context).isPassword ,
                          onFieldSubmitted: (value){
                          },
                          onTap: (){
                            ShopRegisterCubit.get(context).changIconRegister();
                          },
                          decoration:InputDecoration(
                            labelText:"password",
                            prefixIcon: Icon(
                                Icons.lock
                            ),
                            suffixIcon:Icon(
                              ShopRegisterCubit.get(context).suffix,
                            ),
                            border:OutlineInputBorder(),
                          ),
                          validator:(value) {
                            if(value!.isEmpty){
                              return "password must not be empty ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height:20,
                        ),
                        TextFormField(
                          controller:phoneController ,
                          keyboardType:TextInputType.phone,
                          onFieldSubmitted: (String value){
                            print(value);
                          },
                          decoration:InputDecoration(
                            labelText:"Phone",
                            prefixIcon: Icon(
                                Icons.phone
                            ),
                            border:OutlineInputBorder(),
                          ),
                          validator:(value) {
                            if(value!.isEmpty){
                              return "phone must not be empty ";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height:20,
                        ),
                        ConditionalBuilder(
                          condition: state is!ShopRegisterLoadingState,
                          builder: (context)=> Container(
                            width:double.infinity,
                            color: Colors.blue,
                            child: MaterialButton(onPressed: (){
                              if(fromKey.currentState!.validate())
                              {
                                ShopRegisterCubit.get(context).userRegister(

                                  name:nameController.text,
                                  email: emailController.text,
                                  password:passwordController.text,
                                  phone:phoneController.text,

                                );
                              }
                            },
                              child: Text("REGISTER",
                                style: TextStyle(
                                    color: Colors.white
                                ),),),
                          ),
                          fallback: (context)=>Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
