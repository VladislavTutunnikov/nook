import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/models/category_model.dart';
import 'package:nook/api/repositories/nook_repository.dart';

part 'categories_event.dart';
part 'categories_state.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc({required this.nookRepository}) : super(CategoriesInitial()) {
    on<LoadCategories>((event, emit) async {
      emit(CategoriesLoading());
      try {
        final categories = await nookRepository.getNookCategories();
        emit(CategoriesLoaded(categories: categories));
      } catch (e) {
        emit(CategoriesLoadingFailure(error: e.toString()));
      }
    });
  }

  final NookRepository nookRepository;
}
