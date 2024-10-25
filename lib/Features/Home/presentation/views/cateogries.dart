import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/cubit.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/states.dart';
import 'package:shop_app/Features/Home/presentation/views/widgets/category_item.dart';

class CateogriesScreen extends StatelessWidget {
  const CateogriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state){
        return ListView.separated(
            itemBuilder: (context,index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data!.data[index]),
            separatorBuilder: (context,index)=>Container(
              color: Colors.grey,
              width: double.infinity,
              height: 1.0,
            ),
            itemCount: ShopCubit.get(context).categoriesModel!.data!.data.length,
        );
      } ,

    );
  }
}
