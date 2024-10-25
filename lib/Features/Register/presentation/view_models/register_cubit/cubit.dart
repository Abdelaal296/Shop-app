import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/dio_helper.dart';
import 'package:shop_app/Core/end_points.dart';
import 'package:shop_app/Features/Login/data/login_model.dart';
import 'package:shop_app/Features/Register/presentation/view_models/register_cubit/states.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>{

   ShopRegisterCubit():super(ShopRegisterInitialState());
   static ShopRegisterCubit get(context) => BlocProvider.of(context);

   ShopLoginModel? loginModel ;
   void userRegister({
     required String email,
     required String password,
     required String name,
     required String phone,
}){
     emit(ShopRegisterLoadingState());
     DioHelper.postData(
       url: REGISTER,
       data:{
         'name':name,
         'email': email,
         'password':password,
         'phone':phone,
       } ,
     ).then((value) {
        print(value.data);
        loginModel = ShopLoginModel.fromJson(value.data);
       emit(ShopRegisterSuccessState(loginModel));
     }).catchError((error){
       print(error.toString());
       emit(ShopRegisterErrorState(error));
     });
   }
   IconData suffix = Icons.visibility_outlined;
   bool isPassword = true;

   void changeSuffix(){

     isPassword= !isPassword;
     suffix = isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
     emit(ShopRegisterChangeSuffixState());
   }
}