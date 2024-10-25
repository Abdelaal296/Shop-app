import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/components.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/cubit.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/states.dart';
import 'package:shop_app/Features/Home/presentation/views/widgets/build_products.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status){
            showToast(text: state.model.message, state: ToastStates.ERROR);
          }
        }
      } ,
      builder: (context,state){
        return ConditionalBuilder(
          condition:ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context)=>productsBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoriesModel,context),
          fallback:(context)=> const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

  
  
  
}
