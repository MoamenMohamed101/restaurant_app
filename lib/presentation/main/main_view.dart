import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/main/home/view/home_view.dart';
import 'package:restaurant_app/presentation/main/notification/view/notification_view.dart';
import 'package:restaurant_app/presentation/main/search/view/search_view.dart';
import 'package:restaurant_app/presentation/main/settings/view/settings_view.dart';
import 'package:restaurant_app/presentation/resources/color_manager.dart';
import 'package:restaurant_app/presentation/resources/strings_manager.dart';
import 'package:restaurant_app/presentation/resources/values_manager.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _pages = [
    const HomePage(),
    const SearchPage(),
    const NotificationPage(),
    const SettingsPage(),
  ];

  final List<String> _titles = [
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notification.tr(),
    AppStrings.settings.tr(),
  ];
  int _currentIndex = 0;

  void onItemTapped(int index) => setState(() => _currentIndex = index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _titles[_currentIndex],
          style: Theme.of(context).textTheme.titleSmall,
        ),
        backgroundColor: ColorManager.primaryColor,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManager.black,
              spreadRadius: AppSize.s1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManager.primaryColor,
          unselectedItemColor: ColorManager.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppStrings.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: AppStrings.search.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: AppStrings.notification.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppStrings.settings.tr(),
            ),
          ],
          onTap: onItemTapped,
        ),
      ),
    );
  }
}