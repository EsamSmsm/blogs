part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppInitial extends AppState {}

class GetBlogsLoadingState extends AppState {}

class GetBlogsSuccessState extends AppState {}

class GetBlogsErrorState extends AppState {}
