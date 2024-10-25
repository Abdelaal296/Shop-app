import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/dio_helper.dart';
import 'package:shop_app/Core/end_points.dart';
import 'package:shop_app/Features/Login/data/login_model.dart';
import 'package:shop_app/Features/Login/presentation/view_models/cubit/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{

   ShopLoginCubit():super(ShopLoginInitialState());
   static ShopLoginCubit get(context) => BlocProvider.of(context);

   ShopLoginModel? loginModel ;
   void userLogin({
     required String email,
     required String password,
}){
     emit(ShopLoginLoadingState());
     DioHelper.postData(
       url: LOGIN,
       data:{
         'email': email,
         'password':password,
       } ,
     ).then((value) {
        loginModel = ShopLoginModel.fromJson(value.data);
       emit(ShopLoginSuccessState(loginModel));
     }).catchError((error){
       emit(ShopLoginErrorState(error.toString()));
     });
   }
   IconData suffix = Icons.visibility_outlined;
   bool isPassword = true;

   void changeSuffix(){

     isPassword= !isPassword;
     suffix = isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined;
     emit(ShopLoginChangeSuffixState());
   }
}