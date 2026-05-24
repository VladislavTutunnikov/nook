import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/api/di/injection.dart';
import 'package:nook/api/repositories/nook_repository.dart';
import 'package:nook/features/main_screen/pages/search_page/bloc/search_bloc.dart';
import 'package:nook/generated/l10n.dart';
import 'package:nook/shared/widgets/error_message.dart';
import 'package:nook/shared/widgets/loading_dots.dart';
import 'package:nook/shared/widgets/nook_list.dart';
import 'package:nook/shared/widgets/search_field.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _isFocused = false;

  bool _showFloatingButton = false;
  final ScrollController _scrollController = ScrollController();
  Timer? _debounce;

  late final SearchBloc _searchBloc;

  void _onScroll() {
    final state = _searchBloc.state;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;

    if (maxScroll > 650) {
      if (currentScroll > 600 && !_showFloatingButton) {
        setState(() => _showFloatingButton = true);
      } else if (currentScroll < 600 && _showFloatingButton) {
        setState(() => _showFloatingButton = false);
      }
    }

    if (state is SearchLoaded) {
      if (state.hasMore && currentScroll >= maxScroll - 200) {
        _searchBloc.add(
          SearchNooks(prompt: _textController.text, offset: state.offset),
        );
      }
    }
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchBloc.add(SearchNooks(prompt: value, isRefresh: true));
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });

    _searchBloc = SearchBloc(nookRepository: getIt<NookRepository>());
    _searchBloc.add(SearchNooks());

    _scrollController.addListener(() => _onScroll());
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _textController.dispose();
    _searchBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.only(
                  top: 60,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(color: AppColors.lightGrey, width: 1),
                ),
                child: SearchField(
                  isFocused: _isFocused,
                  focusNode: _focusNode,
                  controller: _textController,
                  onChanged: _onSearchChanged,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: BlocBuilder<SearchBloc, SearchState>(
                bloc: _searchBloc,
                builder: (context, state) {
                  if (state is SearchEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        S.of(context).tryToFindSomething,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    );
                  } else if (state is SearchLoaded) {
                    return NookList(
                      placeholderText: S.of(context).nothingWasFound,
                      placeholderTextAlign: TextAlign.center,
                      placeholderTextPadding: const EdgeInsets.only(top: 15),
                      nooks: state.nooks,
                      showLoading: state.hasMore,
                    );
                  } else if (state is SearchLoadingFailure) {
                    return Center(
                      child: ErrorMessage(
                        onTap: () {
                          _onSearchChanged('');
                          _textController.clear();
                        },
                      ),
                    );
                  } else {
                    return const Center(child: LoadingDots());
                  }
                },
              ),
            ),
          ],
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: _showFloatingButton
              ? FloatingActionButton(
                  elevation: 0,
                  onPressed: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    );
                  },
                  child: SvgPicture.asset(
                    AppIcons.chevronUp,
                    width: 30,
                    height: 30,
                  ),
                )
              : const SizedBox(),
        ),
      ],
    );
  }
}
