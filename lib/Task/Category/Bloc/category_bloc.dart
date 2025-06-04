import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro2/Task/Category/Bloc/category_event.dart';
import 'package:pro2/Task/Category/Bloc/category_state.dart';
import 'package:pro2/Task/Category/api_repository/api_repository.dart';


class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository repository;

  CategoryBloc(this.repository) : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoryLoading());
      try {
        final categories = await repository.fetchCategories();
        emit(CategoryLoaded(categories));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
  }
}
