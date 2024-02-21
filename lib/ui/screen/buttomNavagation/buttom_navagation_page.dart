import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../../../conustant/my_colors.dart';
import 'fav/fav_screen.dart';
import 'home/home_screen.dart';





class ButtomNavagationPage extends StatefulWidget{
  var selectedIndex;

  ButtomNavagationPage(this.selectedIndex);

  @override
  State<StatefulWidget> createState() {
    return _ButtomNavagationPage();
  }
}

class _ButtomNavagationPage extends State<ButtomNavagationPage>{
  int _selectedIndex = 0;
  int? selectedFlage;
  //buttom Navigation click/////
  List<Widget> NavigationScreen=[
    HomeScreen(),
    FavScreen(),
  ];

  @override
  void initState() {
    _selectedIndex=widget.selectedIndex;
    super.initState();
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
        child: NavigationScreen[_selectedIndex],
      ),
    ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Colors.white,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/home_unselected.svg'),
                label: "home".tr(),
                activeIcon: SvgPicture.asset('assets/home.svg')),
            BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/element.svg'),
                label: "favourite".tr(),
                activeIcon: SvgPicture.asset('assets/element_selected.svg')),
          ],
        currentIndex: _selectedIndex,
        selectedItemColor: MyColors.MainColor,
        onTap: _onItemTapped,
      ),
    );
  }

}