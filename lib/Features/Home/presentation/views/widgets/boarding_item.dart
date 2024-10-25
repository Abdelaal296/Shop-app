import 'package:flutter/material.dart';
import 'package:shop_app/Features/Home/data/models/boarding_model.dart';

Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image : AssetImage('${model.image}'),
        ),
      ),
      Text(
        '${model.title}',
        style: const TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
      Text(
        '${model.body}',
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 20.0,
      ),
    ],
  );