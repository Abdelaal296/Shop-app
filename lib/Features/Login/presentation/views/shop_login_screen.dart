import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/cache_helper.dart';
import 'package:shop_app/Core/components.dart';
import 'package:shop_app/Features/Home/presentation/views/shop_layout.dart';
import 'package:shop_app/Features/Login/presentation/view_models/cubit/cubit.dart';
import 'package:shop_app/Features/Login/presentation/view_models/cubit/states.dart';
import 'package:shop_app/Features/Register/presentation/views/register_screen.dart';
import 'package:shop_app/constants.dart';

class ShopLoginScreen extends StatelessWidget {

  var formkey =GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  ShopLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
          listener: (context,state){
            if(state is ShopLoginSuccessState){
              if((state.loginModel!.status)!){
                print(state.loginModel!.message);
                print(state.loginModel!.data!.token);

                CacheHelper.saveData(key: 'token', value: state.loginModel!.data!.token).then((value) {
                  token= (state.loginModel!.data!.token)!;
                  navigateAndFinish(context, const ShopLayout());
                });
              }else{
                print(state.loginModel!.message);

                showToast(
                    text: (state.loginModel!.message)!,
                    state: ToastStates.ERROR,
                );
              }
            }else if(state is ShopLoginErrorState){
              showToast(
                    text: (state.error)!,
                    state: ToastStates.ERROR,
                );
            }
          },
          builder: (context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'LOGIN',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Login now to browse our offers',
                          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                              color: Colors.grey
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        defualtFormField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your email ';
                            }
                          },
                          label: 'Email Address',
                          prefix: Icons.email_outlined,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        defualtFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          isPassword: ShopLoginCubit.get(context).isPassword,
                          onSubmit:(value){
                            if(formkey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,);
                            }
                          },
                          validate: (String? value){
                            if(value!.isEmpty){
                              return 'Please enter your password ';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                          suffix: ShopLoginCubit.get(context).suffix,
                          suffixPressed: (){
                            ShopLoginCubit.get(context).changeSuffix();
                          },


                        ),
                        const SizedBox(
                          height: 20.0,
                        ),

                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder:(context)=>defualtButton(
                            function: (){
                              if(formkey.currentState!.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text,);
                              }
                            },
                            text: 'LOGIN',
                            background: Colors.deepOrange,
                          ),
                          fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\`t have an account?',
                            ),
                            TextButton(
                                onPressed: (){
                                  navigateTo(context, RegisterScreen());
                                  },
                                child: const Text(
                                  'REGISTER NOW',
                                ),
                              ) ,

                          ],
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
