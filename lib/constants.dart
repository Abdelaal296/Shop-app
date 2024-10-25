import 'package:shop_app/Core/cache_helper.dart';
import 'package:shop_app/Core/components.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/cubit.dart';
import 'package:shop_app/Features/Login/presentation/views/shop_login_screen.dart';

void signOut(context){
  CacheHelper.removeData(key: 'token').then((value) {
    ShopCubit.get(context).currentIndex=0;
    if(value!) {
      navigateAndFinish(context, ShopLoginScreen(),);
    }
  });
}
String token ='';