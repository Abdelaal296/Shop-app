 import 'package:flutter/material.dart';
import 'package:shop_app/Features/Home/data/models/favorites_model.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/cubit.dart';

Widget buildFavorites(FavoritesData model,context) =>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage((model.product!.image)!),
              width:120.0,
              height: 120.0,
            ),
            if(model.product!.discount != 0)
              Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                child: const Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 15.0,
        ),
        Expanded(
          child: SizedBox(
            height: 120.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (model.product!.name)!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Text(
                      model.product!.price.toString(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    if(model.product!.discount != 0)
                      Text(
                        model.product!.oldPrice.toString(),
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.product!.id]! ? Colors.deepOrange : Colors.grey,
                      child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites((model.product!.id)!);
                          // print(model.id);
                        },
                        icon: const Icon(
                          Icons.favorite_border,
                          size: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );