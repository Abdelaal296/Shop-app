import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/dio_helper.dart';
import 'package:shop_app/Core/end_points.dart';
import 'package:shop_app/Features/Home/data/models/categories_model.dart';
import 'package:shop_app/Features/Home/data/models/change_favorite_model.dart';
import 'package:shop_app/Features/Home/data/models/favorites_model.dart';
import 'package:shop_app/Features/Home/data/models/home_model.dart';
import 'package:shop_app/Features/Login/data/login_model.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/states.dart';
import 'package:shop_app/Features/Home/presentation/views/cateogries.dart';
import 'package:shop_app/Features/Home/presentation/views/favorites.dart';
import 'package:shop_app/Features/Home/presentation/views/products.dart';
import 'package:shop_app/Features/Home/presentation/views/settings.dart';
import 'package:shop_app/constants.dart';

class ShopCubit extends Cubit<ShopStates>{

  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context)=> BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> bottomScreens =[
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),

  ];
  void changeBottomNavBar(index){
    currentIndex=index;
    emit(ShopChangeBottomNavBarState());
  }

   HomeModel? homeModel;

    Map<int,bool?> favorites={};

  void getHomeData(){
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(url: HOME,token: token).then((value) {
      homeModel=HomeModel.fromJson(value.data);

     for (var element in homeModel!.data!.products) {
       favorites.addAll({element.id : element.inFavorites});
     }
      emit(ShopSuccessHomeDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });

  }

  CategoriesModel? categoriesModel;

  void getCategoriesData(){

    DioHelper.getData(url: GET_CATEGORIES,token: token).then((value) {
      categoriesModel=CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });

  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId){
    favorites[productId]= !favorites[productId]!;

    emit(ShopChangeFavoritesState());
    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id':productId,
        },
      token: token,
    ).then((value) {
      changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
      if(!changeFavoritesModel!.status){
        favorites[productId]= !favorites[productId]!;
      }else{
        getFavoritesData();
      }
      emit(ShopSuccessChangeFavoritesState(changeFavoritesModel!));
    }).catchError((error){
      favorites[productId]= !favorites[productId]!;
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavoritesData(){

    emit(ShopLoadingGetFavoritesDataState());

    DioHelper.getData(url: FAVORITES,token: token).then((value) {
      favoritesModel=FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetFavoritesDataState());
    });

  }


  ShopLoginModel? userModel;

  void getUserData(){

    emit(ShopLoadingGetUserDataState());

    DioHelper.getData(url: PROFILE,token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(ShopSuccessGetUserDataState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetUserDataState());
    });

  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,
}){

    emit(ShopLoadingUpdateUserProfileState());

    DioHelper.putData(
        url:UPDATE_PROFILE,
        token: token,
    data: {
          'name':name,
          'email':email,
          'phone':phone,
    },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      // printFullText(value.data.toString());
      emit(ShopSuccessUpdateUserProfileState(userModel));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateUserProfileState());
    });

  }

}
