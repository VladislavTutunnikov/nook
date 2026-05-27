import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/features/nook_categories_screen/bloc/categories_bloc.dart';
import 'package:nook/features/nook_categories_screen/widgets/nook_category_card.dart';
import 'package:nook/shared/widgets/custom_back_button.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/theme/colors.dart';

@RoutePage()
class NookCategoriesScreen extends StatefulWidget {
  const NookCategoriesScreen({super.key});

  @override
  State<NookCategoriesScreen> createState() => _NookCategoriesScreenState();
}

class _NookCategoriesScreenState extends State<NookCategoriesScreen> {
  final CategoriesBloc _categoriesBloc = CategoriesBloc(
    nookRepository: getIt<NookRepository>(),
  );

  Future<void> _onRefresh() async {
    _categoriesBloc.add(LoadCategories());
  }

  @override
  void initState() {
    super.initState();
    _categoriesBloc.add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        bloc: _categoriesBloc,
        builder: (context, state) {
          if (state is CategoriesLoaded) {
            return RefreshIndicator(
              backgroundColor: AppColors.white,
              color: AppColors.black,
              onRefresh: _onRefresh,
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 15,
                            top: 60,
                            bottom: 25,
                          ),
                          child: CustomBackButton(color: AppColors.black),
                        ),
                        ListView.builder(
                          padding: const EdgeInsets.all(0),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.categories.length,
                          itemBuilder: (context, index) => NookCategoryCard(
                            categoryName: state.categories[index].name,
                            onTap: () => AutoRouter.of(
                              context,
                            ).pop(state.categories[index]),
                          ),
                        ),
                        const SizedBox(height: 60),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is CategoriesLoadingFailure) {
            return Center(child: ErrorMessage(onTap: _onRefresh));
          } else {
            return const Center(child: LoadingDots());
          }
        },
      ),
    );
  }
}
