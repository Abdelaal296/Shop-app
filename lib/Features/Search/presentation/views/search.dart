import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/components.dart';
import 'package:shop_app/Features/Search/presentation/view_models/search_cubit/cubit.dart';
import 'package:shop_app/Features/Search/presentation/view_models/search_cubit/states.dart';
import 'package:shop_app/Features/Search/presentation/views/widgets/build_list_products.dart';

class ShopSearchScreen extends StatelessWidget {
  var formkey =GlobalKey<FormState>();

  var searchController= TextEditingController();

  ShopSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defualtFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String? value){
                        if(value!.isEmpty){
                          return 'search must not be empty';
                        }
                        return null;
                      },
                      label: "Search",
                      prefix: Icons.search,
                    onSubmit: (String text){
                        SearchCubit.get(context).search(text);
                    },
                  ),
                  const SizedBox(height: 10.0,),
                  if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                  const SizedBox(height: 10.0,),
                  if(state is SearchSuccessState)
                    Expanded(
                    child: ListView.separated(
                      itemBuilder: (context,index)=>buildListProduct(SearchCubit.get(context).searchModel!.data!.data[index],context),
                      separatorBuilder: (context,index)=>Container(
                        color: Colors.grey,
                        width: double.infinity,
                        height: 1.0,
                      ),
                      itemCount: SearchCubit.get(context).searchModel!.data!.data.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        } ,
      ),
    );
  }

  
}
