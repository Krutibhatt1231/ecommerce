import 'package:equatable/equatable.dart';

abstract class CategoriesState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CategoriesLoadingState extends CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesLoadedState extends CategoriesState {
  var categories;
  CategoriesLoadedState({required this.categories});
}

class CategoriesListErrorstate extends CategoriesState {
  final error;
  CategoriesListErrorstate({this.error});
}
