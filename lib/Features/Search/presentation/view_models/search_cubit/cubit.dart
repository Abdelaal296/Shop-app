import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/dio_helper.dart';
import 'package:shop_app/Core/end_points.dart';
import 'package:shop_app/Features/Search/data/search_model.dart';
import 'package:shop_app/Features/Search/presentation/view_models/search_cubit/states.dart';
import 'package:shop_app/constants.dart';

class SearchCubit extends Cubit<SearchStates>{
  
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);
  
  SearchModel? searchModel;
  
  void search(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: SEARCH,
      token: token,
      data: {
        'text':text,
      },
    ).then((value) {
      searchModel=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      emit(SearchErrorState());
      print(error.toString());
    });
  }
}