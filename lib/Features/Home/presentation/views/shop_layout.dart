import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/components.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/cubit.dart';
import 'package:shop_app/Features/Home/presentation/view-models/cubit/states.dart';
import 'package:shop_app/Features/Search/presentation/views/search.dart';


class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder:(context,state){
        var cubit =ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
                'Jumia'
            ),
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, ShopSearchScreen(),);
                  },
                  icon: Icon(Icons.search,
                  ),
              ),
            ],
          ),
          body:cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.amber, 
        unselectedItemColor: Colors.black, 
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                      Icons.home,
                  ),
                  label: 'Home',


              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.apps,
                ),
                label: 'Categories',


              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                ),
                label: 'Favorites',


              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',


              ),
            ],
          ),
        );
      } ,
    );
  }
}
