import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nook/features/main_screen/pages/account_page/view/account_page.dart';
import 'package:nook/features/main_screen/pages/search_page/view/search_page.dart';
import 'package:nook/theme/colors.dart';
import 'package:nook/theme/icons.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;

  DateTime? _lastPressed;

  void _onSelectTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  Color _currentColor(int index) {
    return _selectedTab == index ? AppColors.black : AppColors.darkGrey;
  }

  static final List<Widget> _pages = [
    const AccountPage(),
    const SearchPage(),
    const Text('data'),
    const AccountPage(),
    const AccountPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final now = DateTime.now();

        if (_lastPressed == null ||
            now.difference(_lastPressed!) > const Duration(seconds: 2)) {
          _lastPressed = now;
          return;
        }

        await SystemNavigator.pop();
      },
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: _onSelectTab,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.house,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _currentColor(0),
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.search,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _currentColor(1),
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.plusSquare,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _currentColor(2),
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.bell,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _currentColor(3),
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppIcons.user,
                width: 24,
                height: 24,
                colorFilter: ColorFilter.mode(
                  _currentColor(4),
                  BlendMode.srcIn,
                ),
              ),
              label: '',
            ),
          ],
        ),
        body: _pages[_selectedTab],
      ),
    );
  }
}
