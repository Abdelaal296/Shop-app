import 'package:flutter/material.dart';
import 'package:shop_app/Features/Home/data/models/home_model.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/cubit.dart';

Widget buildGridProduct(ProductModel model,context)=>Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage('${model.image}'),
              width: double.infinity,
              height: 200.0,
            ),
            if(model.discount != 0)
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
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                 fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.deepOrange,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  if(model.discount != 0)
                    Text(
                      '${model.oldPrice}',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  CircleAvatar(
                    radius: 15.0,
                    backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.deepOrange : Colors.grey,
                    child: IconButton(
                        onPressed: (){
                          ShopCubit.get(context).changeFavorites(model.id);
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
      ],
    ),
  );