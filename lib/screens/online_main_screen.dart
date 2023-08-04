import 'package:dm_mobile/screens/bottom_nav_widget.dart';
import 'package:dm_mobile/screens/cart_page.dart';
import 'package:dm_mobile/screens/online_home_page.dart';
import 'package:dm_mobile/screens/profile_page.dart';
import 'package:dm_mobile/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/main_screen_provider.dart';
import '../widgets/bottom_nav.dart';

class OnlineMainScreen extends StatelessWidget {
  OnlineMainScreen({super.key});

  List<Widget> pageList = const [
    OnlineHomePage(),
    SearchPage(),
    OnlineHomePage(),
    CartPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        return Scaffold(
          body: pageList[mainScreenNotifier.pageIndex],
          bottomNavigationBar: const BottomNavBar(),
        );
      },
    );
  }
}
