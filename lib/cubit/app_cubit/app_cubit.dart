import 'package:bloc/bloc.dart';
import 'package:blogs_task/models/blogs_model.dart';
import 'package:blogs_task/network/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context)=> BlocProvider.of(context);

  List<dynamic> blogsModel;
  void getBlogs(){
    emit(GetBlogsLoadingState());
    DioHelper.getData(url: "wp/v2/posts",
    query: {"_fields":"id,title,content,date"}).then((value) {
      print(value.data);
      blogsModel = value.data.map((e) => BlogsModel.fromJson(e)).toList();
      emit(GetBlogsSuccessState());
    }).catchError((error){
      emit(GetBlogsErrorState());
      print(error);
    });
  }
}
