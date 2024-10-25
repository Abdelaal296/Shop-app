import 'package:flutter/material.dart';
import 'package:shop_app/Features/Home/data/models/categories_model.dart';

Widget buildCategories(DataModel model)=>Stack(
    alignment: Alignment.bottomCenter,
    children :[
      Image(
        image : NetworkImage(model.image),
        width: 100.0,
        height: 100.0,
      ),
      Container(
        width: 100.0,
        color: Colors.black.withOpacity(0.6),
        child: Text(
          model.name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
        ),
      ),
    ],
  );