import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/Features/Home/data/models/categories_model.dart';
import 'package:shop_app/Features/Home/data/models/home_model.dart';
import 'package:shop_app/Features/Home/presentation/views/widgets/build_categories.dart';
import 'package:shop_app/Features/Home/presentation/views/widgets/grid_product.dart';

Widget productsBuilder(HomeModel? model,CategoriesModel? categoriesModel,context)=>SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:model!.data!.banners.map((e) =>Image(image: NetworkImage('${e.image}'),
              width: double.infinity,
              fit: BoxFit.cover,
            ) ).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage: 0,
              viewportFraction: 1.0,
              autoPlay: true,
              enableInfiniteScroll: false,
              reverse: false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              scrollDirection: Axis.horizontal,


            ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 100.0,
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index)=>buildCategories(categoriesModel.data!.data[index]),
                  separatorBuilder:(context,index)=>const SizedBox(width: 10.0,) ,
                  itemCount: categoriesModel!.data!.data.length,

                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.65,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount:2,
            children: List.generate(
                model.data!.products.length,
                    (index) => buildGridProduct(model.data!.products[index],context),
            ),
          ),
        ),

      ],
    ),
  );