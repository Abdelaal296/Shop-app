import 'package:flutter/material.dart';
import 'package:shop_app/Features/Home/data/models/categories_model.dart';

Widget buildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(model.image),
          width: 100.0,
          height: 100.0,
        ),
        const SizedBox(width: 10.0,),
        Text(
          model.name,
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24.0
          ),
        ),
        const Spacer(),
        const Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  );