import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/cubit.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/states.dart';
import 'package:shop_app/Features/Home/presentation/views/widgets/build_favorites.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state){
        return ConditionalBuilder(
          condition:state is! ShopLoadingGetFavoritesDataState  ,
          builder: (context)=>ListView.separated(
            itemBuilder: (context,index)=>buildFavorites(ShopCubit.get(context).favoritesModel!.data!.data[index],context),
            separatorBuilder: (context,index)=>Container(
              color: Colors.grey,
              width: double.infinity,
              height: 1.0,
            ),
            itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length,
          ),
          fallback:(context)=>const Center(child: CircularProgressIndicator()),
        );
      } ,

    );
  }

}
