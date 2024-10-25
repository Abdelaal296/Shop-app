import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/cache_helper.dart';
import 'package:shop_app/Core/dio_helper.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/cubit.dart';
import 'package:shop_app/Features/Home/presentation/views/onboarding_screen.dart';
import 'package:shop_app/Features/Home/presentation/views/shop_layout.dart';
import 'package:shop_app/Features/Login/presentation/views/shop_login_screen.dart';
import 'package:shop_app/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  bool? onBoarding = CacheHelper.getData(key:'onBoarding');
  Widget widget;
  token = CacheHelper.getData(key:'token')?? '';

  if(onBoarding != null){
    if(token != ''){
      widget=ShopLayout();
    }else{
      widget=ShopLoginScreen();
    }
  }else{
    widget=OnBoardingScreen();
  }
  DioHelper.init();
  runApp(MyApp(startWidget:widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  MyApp({super.key, required this.startWidget});

  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavoritesData()..getUserData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: startWidget,
      ),
    );
  }
}


