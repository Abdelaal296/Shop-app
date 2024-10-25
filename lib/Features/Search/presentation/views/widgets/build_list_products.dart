import 'package:flutter/material.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/cubit.dart';
import 'package:shop_app/Features/Search/data/search_model.dart';

Widget buildListProduct(Product? model,context) =>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage((model!.image)!),
              width:120.0,
              height: 120.0,
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
                  (model.name)!,
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
                      model.price.toString(),
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.deepOrange,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15.0,
                      backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.deepOrange : Colors.grey,
                      child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites((model.id)!);
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